import React from 'react';
import { Layout, Card } from 'antd';

const { Header, Content } = Layout;

export default function(props) {
  return (
    <Layout>
      <Header>header</Header>
      <Layout>
        <Content style={{height: '100vh', display: 'flex', justifyContent: 'center', alignItems: 'center'}}>
          <Card title="Rate USD <=> RUB" style={{ width: 300, height: 300 }}>
            <p>{props.date}</p>
            <p>{props.rate}</p>
          </Card>
        </Content>
      </Layout>
    </Layout>
  );
}