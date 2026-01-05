Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022086.outbound.protection.outlook.com [52.101.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4172C029D;
	Mon,  5 Jan 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623388; cv=fail; b=NPF64ev/KHQuCWnylYz7XA7lZGT8uP/OBWUgfdEXFc/24McHnSrfMeYjsEDzVUZvXUhW130dun2w3y6JznV6FoU1C4HMw+lztU48kTDaitvKJg4S8yHH7L7xSNg25Af3ClCxPrIkzmkHCy5WsXfMVP3fMgXXlgt1p8nh4Dw5WWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623388; c=relaxed/simple;
	bh=m9bYC4tv79jJfScIG/ZGeE0doCjS/v2GrgFCU/L+mq4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YLgaTp8u1ZtH8uvEgAewscb+X8MkhcDAY/JcrvYCYKCa7uwG8I9kR5c7ijZRShzHscQFCL4qOwm3YrW4QpFOIT4TTMsEK+H5UijyqGBggczcUms7K2u8vpK27VlrFNRhZfvEPmAx7pouB1ONuzYi23NMH9V5t8F2CQBVauGJyV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tx3z57QkPD21IQ/09tCxR3+vtFdA5qHDUCcktizugECwN49LCtCf4LlCDv0k0yEYsRwzqpilg4VuOo34IVa22ilYcW/BFv80TiIF2qz8E2yZW2ARl36iGwbxmzmDQlIYAtnPzlQRX+4jnMys5G2JLzYAng2MTFcb9nbjsBwZf+osp6otSmNq6EtU7/Rt7IAXmhBkjPV3GKsoeeUl8zitisLwN7gXM+mvnS37w6bDWyovSaDeTYCsI5yPLkoTfLwVglhWLz9KrbYFtk72SEPk/7X3fuLz08OvXWhkvHCDNZJMYMZ3ia4+qP6JOFOBfgfGtROg5KvKtok19q8Mksgd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpMttAyyBs88mtBhguGk7gkIrv1SD/SQQ8u7n+S1bSg=;
 b=VqpTFluJpg34pVQpCsTAyRZAThEP+MlwlkguleH2qa4OFzcNrWtkdME279bbsFc6PkhIvU+INR3dz7FwDnpW8AisONuWJSu5ndp4XxqP9YYtJOLzJoR3NWvA8oUIye8PAOjQMnb3JGbP79J9/y+ihQ/u2VnV8HRFzlupm/IkF73dxnuNUeCMg8IV5NCLOLMLAQIgdDWsM3JS3XqLXqNkrVSigGyj14IgsB3eQeZQfsOJDTe+pPpc+8NPyw7cXTWxNyGo4NaZl4Je9FiUgiDleUngHkQyBhrvLDU3WQdgHL3ngQKMlJUM/VjM2kJixI6Aq3LkaXSNy7N1s5tzTb0WjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB6932.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:324::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 14:29:43 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 14:29:43 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: neelx@suse.com,
	sean@ashe.io,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [v2 PATCH 0/2] tracing: Expose global views of active filters and triggers
Date: Mon,  5 Jan 2026 09:29:37 -0500
Message-ID: <20260105142939.2655342-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:408:112::30) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d336f37-59df-48c9-5fb5-08de4c66de37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JiLIQwo5OUV9DIYLLNhrceVq4Z2EkNE6+NuPqTBmG2GXEVQ0pY694ZVDK1g+?=
 =?us-ascii?Q?ix0AgfuEW5fEqNA6Gr5HaG3KrM/VUFsX5Nvrydb9PUtlRI3cnrjcGVdhcQvT?=
 =?us-ascii?Q?jLJ4rmxboafkvxJtlT7KyiuWzfkBM5aX7SB91W1Qufgh8WIKCVcM//IXz1zL?=
 =?us-ascii?Q?GOaMsuuZ/CZILjyCfLq+hLGQQCJptbrWFgRQawlGH0k/v9N4HlprvvMmTFL1?=
 =?us-ascii?Q?8H5qlWRie4g0hSOnLAY8H8pLxySGX9mm55yQkxGA98UOKDSORyGG9c2U3Uxr?=
 =?us-ascii?Q?FV/7RhhAryY3Erpto3CirwgA6HxsKAXZeIuUY734+ADRN/1Qtp/ikAEN8++P?=
 =?us-ascii?Q?OP11aiW2S6wfQcVAAqRu/vkSQ4vD4gevfOXwSXUObXaEOuuDpmJb/ZmVwI3J?=
 =?us-ascii?Q?e0Z/ygcj+ZUthn7yZC1unv8v9mOrmfLz1C+/cqOEr2MCRfICyMMTOOgAtYpF?=
 =?us-ascii?Q?5YEVZwwY/PWvQtHTuW5kjiTB0EUa9bDwM2nNg70UKgk5vPhz07/3FqEt5EmF?=
 =?us-ascii?Q?3SmwMJJazfaVNRFWJQfjtUfSm+0tlvqJifvn98vbqherVeYMKcDNMQBI+cwv?=
 =?us-ascii?Q?iP0HJNmZMBnYdOPlbGtOho79tyZoYVy47uwAnDEkN+GDLWk4+zcWuLlRi41B?=
 =?us-ascii?Q?00qCqNhMWcIxlPFctWmFx3KZIqFfYJ/FkTju9Jft/2lT7+sX8naaST9DKkdZ?=
 =?us-ascii?Q?CUiOdETl8yTf60zjT/bG17dUY5FH9gC5/QToc/8mNYToYw3a3cvW+X6vIt7B?=
 =?us-ascii?Q?42+fgM4fz4e78eMqOtapN7hjhBD96VRWA0qPTUJHkmezpmBuxYm9f8HGyLbP?=
 =?us-ascii?Q?X8L6UkqqiS/YBrDtvFXmIts3uJiqQEUEajTkxVTvpHAE7chSVSkdZOfGYDab?=
 =?us-ascii?Q?PMe65H9Blw2xByGUJ0d5QfXSI2ZzUFqVqgwUT30E1G8f3icNoNXOlvnapBar?=
 =?us-ascii?Q?cpXqN96NBnQhm16Q+J54+QMRORvslL+KuIDD/ypzr4Hc6mA6RCGdzuVrpnC6?=
 =?us-ascii?Q?BXmwfe8k+doCbNNtgeu+qyTQoVXPCH7G/SqghvOfxeCUgEYjf940hf0zkECw?=
 =?us-ascii?Q?PQckcbES4bA0zeVMEayYUXSUB5ij//20QyQMZ99UsTbXvjvuB5XyOOCftLCL?=
 =?us-ascii?Q?Hwnz549hhokERiXAtCLb64Vz2r7aR4OIqf3v7EPmyOM7MylRDxhZfOLvJGl1?=
 =?us-ascii?Q?ir9IFIUsFirY1wwvCoG0UaL6o/gl4k/+LQRX4vI1bwS2PeoBl17BlhUzsMEl?=
 =?us-ascii?Q?sTIRGF1DFP+7ApIV0kEwrHRkUDtucAAo9YCEM3fTTOKOwOo93lsAXqhDYvvS?=
 =?us-ascii?Q?RR9E8hfir7wxVXzGXgP/CVVY8074piFkMdfO3i5uMJJjjUrJhVsqZgq6Kb8O?=
 =?us-ascii?Q?gbbZ+xSYlWKu1FMUg9rn/1NRq7Bo4zPv8f1mX1qA7S45bBogCWr2dPbFGNE4?=
 =?us-ascii?Q?1MaiEpeYw8VkS9L05of3ihO/tK8vz7gJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P/LHaYKfidOoatWcuxm1gDRjSqchgHDYCIyXTGLgIHBlni7+lmjmYxQD9LZU?=
 =?us-ascii?Q?tp5FoD7gbrFLSn1FhszGSk2qcOMqoOIuhzQs2Y8Ya2S7/6z1T1wRd1/EkRRk?=
 =?us-ascii?Q?mCBgonBpUEXTylC0qcD2mcmSfhoQLedjrQyms8pRtiSNbDUZylTqJjQJ39yZ?=
 =?us-ascii?Q?UFUqs8Ca+aS9L/uVUY7EgB/vkzJXsnzgLTsI5ecRldwteF6UBSMgQb2gQUZw?=
 =?us-ascii?Q?59hZOSbPLTm4XBdXZfVt7fmLiw3U8I3JMs8a0uT0HNlaXY874kWLAjgdU0F6?=
 =?us-ascii?Q?3FnrSXpQsljCDrSGttIEZww8htJfGYoB3bLgmJWEMjB6w8ux3LSyAmSPQ+Lr?=
 =?us-ascii?Q?B12p8R83vOB9gijfJf5lNDoqG9hxYst07TEEuH0xGmytZWojpK+s9pNqNEEQ?=
 =?us-ascii?Q?Id1T1q7fH0Ekx1f+xs/xAbBWdMG4W/qvVwjjhk/uSA0eUhJCx26TwenLKcjK?=
 =?us-ascii?Q?3iEFp3RnBBRhW52ffymXBN0ti2uUulmRpqnKb/mmW8KH7gdAG/G8uIgLFSHG?=
 =?us-ascii?Q?tyY3qZpwMCTu3PSXQJwxnHEBe5jRJ0P/cz3TgCNjFerN6B/Lvd/0d2bWb2I8?=
 =?us-ascii?Q?+Ky/Cy6UAQpO1ghJNrPXQaPa4NrHyj3Eyxgb/Y0bdGEiuAkwBZulkFFnGavG?=
 =?us-ascii?Q?IMx6wn5DTrWxDDdlR9D4Xl3YzXoktXLkKBkMFhx7KcQgh8kMU8qfeKw0TX4M?=
 =?us-ascii?Q?zkGkl12b2nViG6oeg+/QTUkwtGZdWMr/YEMJtzVWldj9qxN/nqcUFcNANmR1?=
 =?us-ascii?Q?DJ0zgtdPj0fladeveFz2MkRGWWuFBFEnmmPAaxHW5FKaOm4yA0sH1f+43XOJ?=
 =?us-ascii?Q?j2JkzVlTWDvjy7i6E3vbkNfEmwTcZUt9SYHpRiPFscs78g7OZf5edF4a0OdS?=
 =?us-ascii?Q?4oIOJ9+u99WAyJHEd5xXjoIWSJHJgX0rOFmNYY3+lzuV34cNDuqOyC/7M5QR?=
 =?us-ascii?Q?OfqaD6IMgdwEYcDnFd67oRid/Jt4jVKffqGfcFBr9aVTyks+54G0BpU9/FHA?=
 =?us-ascii?Q?l2caTJ99/9ITdbKUhkm4WEuQF/Q4zVSEJnFfh8nK7NNK1AbcwqzunnJopwgr?=
 =?us-ascii?Q?LY4yjOSx4ULsfdVC6XQDbdaiMVN4O/WroWeDj6vqX6NQbsnwDaWqPUmxkS+s?=
 =?us-ascii?Q?YlY1vds8Uvrj6qAHZFXdsZ6U0WF6IkZiasJHQc7UJqgb/xtOqx5MUPwz8LM5?=
 =?us-ascii?Q?987c0VRgJoCn1knzIJxb54VosECwQ/Hk8/XTtyjD7M93AEpnz/6T2TTFFebX?=
 =?us-ascii?Q?+k6Ugf3dmbOxQGbyfXC9p2cIrUBMvvCz71bM5L0yHmIgBYdGpL5TXM1L/Sa9?=
 =?us-ascii?Q?+T74uzc8nDCJz/DfarUcTBl30o7Nn8c1qrqMXcVSqrPLvpymsYH/b53qLtI0?=
 =?us-ascii?Q?vmmVmNdkZVxSirXhMMo0aFzZH8aB+RsVqHUly8MxC7sLFtsBtCNN33iIX2Qm?=
 =?us-ascii?Q?baWnuF3iFuHEOg3JGvNLulgSyCCQq7iUQVHtuhMkwADQLGapMmhvUzHhaUHj?=
 =?us-ascii?Q?1sesyKQFaloIxBpJbP3PIjMjmsL2BLM8sPUwxRvwQlXp9XWDACPp/aH+VUFj?=
 =?us-ascii?Q?hTARL3Kgs8RstuK6OJMMc8qsC5ld5mqB6W/onomfZzQVffvsi72AeFKIQ6Gh?=
 =?us-ascii?Q?ETUnL6toIqygi3Np/I3Zuj34AHbDobXm4td5I0iJRByZxdD4Kv7UrgptSQg9?=
 =?us-ascii?Q?JXZDtcGyhoLpPtB+P3kblnF8GOsdjpYgZXsKjo8rgf5bS7cGs0CVRUwihSgu?=
 =?us-ascii?Q?ia9fTuM1dw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d336f37-59df-48c9-5fb5-08de4c66de37
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 14:29:43.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPUHZ/HPOTFmYjgUkteYFRaYwieYHWOQ2x5WSiW8gbMSjM+Ut074o5NwtV3D67z8I0oTIYXAUKK/Eb2kwf58cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6932

Hi Steve,

Currently, auditing active Ftrace event filters or triggers requires userspace
to recursively traverse the "events/" directory and read the "filter" or
"trigger" file for every individual event. For monitoring tools, security
auditors, or developers debugging complex tracing setups, this O(n) traversal
is inefficient and cumbersome.

This series introduces two new files at the trace root directory to provide
a consolidated, system-wide view of active event configurations:

    1. show_event_filters: Displays all events with an active filter
    2. show_event_triggers: Displays all events with active triggers

Both files utilise the system:event [tab] config format, allowing for easy
parsing by standard tools (e.g., awk) or custom monitoring agents.

The patches leverage the existing trace_event_file iterators to ensure atomic
and efficient traversal of the event list. Scope-based RCU protection
(guard(rcu)) is used for filter string access, whilst the existing event_mutex
protection within the iterator ensures safe traversal of the event trigger
lists. For triggers, we utilise the internal cmd_ops->print() callbacks to 
guarantee that the consolidated output remains consistent with the legacy
per-event interface.


Changes since v1 [1]:
 - Clarified that all events with filters are listed, regardless of
   enablement state (Steven Rostedt)
 - Optimise filter display logic by utilising the guard(rcu) macro for cleaner 
   scope-based RCU protection and early return (Steven Rostedt)
 - Add show_event_triggers to expose event triggers alongside filters
   (Steven Rostedt)

[1]: https://lore.kernel.org/lkml/20260101233414.2476973-1-atomlin@atomlin.com/

Aaron Tomlin (2):
  tracing: Add show_event_filters to expose active event filters
  tracing: Add show_event_triggers to expose active event triggers

 Documentation/trace/ftrace.rst |  16 +++++
 kernel/trace/trace_events.c    | 122 +++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

-- 
2.51.0

