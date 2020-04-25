import React, { useState } from 'react';
import { DatePicker, Layout, Card, Form, InputNumber, Button, Alert, Space } from 'antd';
import moment from 'moment';

const { Header, Content } = Layout;
const dateFormat = 'DD-MM-YYYY HH:mm';

export default function(props) {
  let currentDate = props.date ? moment(props.date) : moment();
  const [date, setDate] = useState(currentDate);
  const [rate, setRate] = useState(props.rate);
  const [alerts, setAlerts] = useState([]);
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);

  const AlertMessages = () => {
    let messages = alerts.map((message, index) => <Alert closable message={message} key={index} type="error" />)

    return messages;
  }

  const SuccessMessage = () => {
    let text = "Rate successfully published";
    let message = success ? <Alert closable message={text} type="success" /> : null

    return message;
  }

  const disabledDate = (current) => {
    return current && current < moment(moment().subtract(1, 'days')).endOf('day');
  }

  const onDateChnage = (value) => {
    setDate(value);
  }
  
  const onOk = (value) => {
    console.log('onOk: ', value);
  }

  const onRateChange = (value) => {
    console.log('rate', value)
    setRate(value);
  }

  const onFinish = () => {
    setLoading(true)

    const data = {
      rate: {
        price: rate,
        force_date_time: date.format(),
      }
    }

    fetch('/admin/rates', {
      method: 'PUT',
      credentials: 'include',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    })
    .then((response) => {
      setAlerts([]);
      setSuccess(false)

      if (!response.ok) {
        return response.json();
      } else {
        setSuccess(true)
      }
    })
    .then((data) => {
      setLoading(false)
      setAlerts(data.errors);
    })
  }

  return (
    <Layout>
      <Header>header</Header>
      <Layout>
        <Content style={{height: '100vh', display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center'}}>

          <AlertMessages />
          <SuccessMessage />
          <Card title={"Admin rate "} style={{ width: 300, height: 300 }}>
            <Form onFinish={onFinish}>
              <Form.Item label="Rate">
                  <InputNumber
                    onChange={onRateChange}
                    value={rate}
                    style={{width: '100%'}}
                    min={0}
                  />
              </Form.Item>
              <Form.Item label="Date">
                <DatePicker 
                  showTime 
                  format={dateFormat} 
                  onChange={onDateChnage} 
                  onOk={onOk} 
                  value={date}
                  disabledDate={disabledDate}
                  // disabledTime={disabledDateTime}
                />
              </Form.Item>

              <Form.Item>
                <Button type="primary" htmlType="submit" loading={loading}>
                  Submit
                </Button>
              </Form.Item>              
            </Form>
          </Card>
        </Content>
      </Layout>
    </Layout>
  );
}