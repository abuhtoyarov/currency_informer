import React, { useState } from 'react';
import { Layout, Card } from 'antd';
import { createConsumer } from "@rails/actioncable"
const { Header, Content } = Layout;

const consumer = createConsumer();

export default function(props) {
  const [state, setstate] = useState({
    rate: props.rate,
    success: props.success
  });

  consumer.subscriptions.create("RateChannel", {
    received(data) {
      setstate({rate: data.rate, success: data.success});
    }
  });

  return (
    <Layout>
      <Header>header</Header>
      <Layout>
        <Content style={{height: '100vh', display: 'flex', justifyContent: 'center', alignItems: 'center'}}>
          <Card title="USD - RUB" style={{ width: 300, height: 300 }}>
            <p>{state.rate}</p>
          </Card>
        </Content>
      </Layout>
    </Layout>
  );
}