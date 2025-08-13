Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013038.outbound.protection.outlook.com [52.101.127.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874662D2390;
	Wed, 13 Aug 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078690; cv=fail; b=a49WSKKZGWB/t/QZG8SsTjjqQhYb35hXZIMJhvodnXFn3eeTiJG2SWzWuVbwSyFwsFxEn73oepp1GRevYU+slFMlhQZH9LvPNGnzbYOYt8eZ8vvwYlZrBlwtOsAn/uKX3A3M5vjJIveMkk1YaqF/BerKpQ+WsWlhMKdrRRkRgI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078690; c=relaxed/simple;
	bh=6eEv2FAqJ0Zjy1lntVHsmFgth8lU2x0d3BVfRdebH7o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tqnbs+d6bYsf6XplQJI7LjJwXPKNoh5M7iBpjh2KFg9msIAEXa06da4wKTw1RynO9W9ijf+XHPu11XT1mf3TL5mxTyim2m0hAPRHxbITqwq89AhYRcDVJBd/7Ry+PISPVn1lGtKo9pjpuIgz147VMKpQTDLcQO1Bx2rFjFiPJKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JVnooOCu; arc=fail smtp.client-ip=52.101.127.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JVnooOCu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xjb1Jj3nG+DyoFoy5jIWy0ZYTFzdnK4y+di+Yyz+jI2olnlvvX5q2HotA4WnSzby35MgVGgbEEJC667ENuXj/cDkebM3oupC7hKY1dJwlqQ+y58YPlOUvUjLfgrwhu9FoyS0L0EI1M/VEfnnPwFWGUFv9RwiqWLlzBVEjGbPDknGAxYkGWGri53OHQaK+LJbqfXpT3d0RU2cPwpZyctBQMAPhmgg+FvSTprYpD9dWyLgJxwihlo8M8hHCXEAITpjfg2jEJ0f0L5abt48aOwtF3seS9HkZk8ZFl+gwPTsqWDCLzPkB1uU1SnLP2f1VnC1f/OpevfsEqFONVEEOAc0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0xfqzaa5CANDX76oX4AmpYEDIEHT6DermT03A9aA4Y=;
 b=uRXqKvataPNXNgKOnfyl2alaIeZCOa6f9H3QQ+Eo0AMl/8rGf5r7SPpeooMIhxCx2S4oBCw7nawiR1XF0yAnpDQg84rbvnr6rZzUlA86O5licfDoZtPk1dG/ZqLIjL0nfg52Rp7HhPQ9fBN4NsJkJdZPJEx+ahKY89+AtJOVdq1sMf9PNvS4jpicvBLJqFRW2M+wlOmEKNeb0zoq4iKAlPKjsf1TpLsCoR2tPtyE9eK6PCcgr8Lk7y5Uxm2kQ0WQsByX8IDx1aUl1HKd6FdnKX54fPwDzfvlxA5p60qcPfNzgL71Ns+AFYmdMaMdxyMFZUVVF3WQKZL9RVnffhizOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0xfqzaa5CANDX76oX4AmpYEDIEHT6DermT03A9aA4Y=;
 b=JVnooOCunw0EFyDdKYgI9/Z+P+3YgBWOowSl8ZXv+S0wM1acpvZiexDrDdlxu9REgqE86go4j24XAvbe1DXGjxgf1xK/rg8mh/jdCI0vdqji+7R6BB1z2BqoDK6moTGrVtwvAbh0cIOjqThnaz7HAAUJ8Le+0m3yN3LoouAXBrSYn9f9qD3cDEREZO4AVhJn+qVnwwz4cLqOQv7adgvsPM5Kcx68iKQG0yMUx+p5+rHJ/fRccqbel/Q5DeLqN3uzSgy8Le5A5T27sMnR8a5rzaaXNTYQi+Cbgr33Q7Ql0uDxE2dhumKOHFLKj/0DAta0LlnXxPwHedcTETR/ZafiCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEZPR06MB6927.apcprd06.prod.outlook.com (2603:1096:101:1ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 09:51:25 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 09:51:25 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] ring-buffer: Remove redundant semicolons
Date: Wed, 13 Aug 2025 17:51:14 +0800
Message-Id: <20250813095114.559530-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEZPR06MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1da7f8-9ea8-46dc-0bbd-08ddda4ef75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ix8jrEB82KWXqdzbjl3zPfT/WhJ+nDNgqbHdxOQpGUgJ8mfWY7JPK5AcjDfg?=
 =?us-ascii?Q?jpx4rVeymPhnvNuIy6pxYfcjyXKq9cXS+hGSSTuyxKLFi/xGsi84/oov2mDf?=
 =?us-ascii?Q?GEkQYbglvirJRuUqLDQV+dZNghQMyBMgpUSy8m4MTJnNSsPfT7bah4C3XbhV?=
 =?us-ascii?Q?+QG9Ki9QFiKYW8deeaVOW5YwsEf90FOrt7avRUK+17HJgMKJHTNfZVLRyebV?=
 =?us-ascii?Q?uJQVmD/bI3wla09sV3u9f66kZA1RFq0xHyTcWI/1Ed7yiZ125PlwkFVaS+J4?=
 =?us-ascii?Q?PE/a4n6ajEvu1wq9U8/kxGYOsq40LJWayam+MeSAuXfWQKR49ceU9WIDqFKo?=
 =?us-ascii?Q?hJG9f1hcFwVTwcdQ4r/kUEYAXBGKuwkBfHb6NB1BJtUo+Wy8KLLCAizwYaSc?=
 =?us-ascii?Q?g5KPYSaLBaQMVUMCY5NuYbHXRuPOrvChcyq41RiNgOBYbF5sgBlZJce7yrWV?=
 =?us-ascii?Q?IOtj9L6pTgRUfnqpPOUY5AQ4OY3qCGsjil11fccCaOTmRaOWp/Ny3DzAF9dm?=
 =?us-ascii?Q?G4CI+fgMo7W7kBdtntjKsSoP8mk+HVBJm/ixWA2lGzzBZ93KRLUwQ5GrO8HZ?=
 =?us-ascii?Q?4KLMieAqiuKhv6mA/XvuA/D/xOnhlFiZHELLts5/inYWeK65+NHTDvP/asM7?=
 =?us-ascii?Q?4iePvuCniStrX9pMYZGMCeSYRNO5aSma1pBGhHXY5Y0sBMHXz846GjsBcWDv?=
 =?us-ascii?Q?B9U7vIUhTS6nbC6nF14/nDSc6/DwUYJsdZKdnfo/2wINyBn5qtWSBdv+CHtA?=
 =?us-ascii?Q?boBweyoYLbHH5Y8SFoBSiz+GwuKl53DjO7iHrUySkwEDxkqnNMpufJvwIefv?=
 =?us-ascii?Q?rm57SJnQskFll25LJMeFXtOAdfQhbYkdPIMU2Isy+5QXm8Cyy7eF5W4Kj2FG?=
 =?us-ascii?Q?BfQ79FixnuHYIg96/vX+0Qj8aXrdBZdre9GwErBeSiIQXywPhY+OKXU9V98m?=
 =?us-ascii?Q?YH18z24GX7EAtCS25n6AKHJzw9bQAIZDfcuPJrBYW8nlRsYdDLphL3jPvi2G?=
 =?us-ascii?Q?6NG/2r9/o1r00OzvOlj1+U8z6Uq4K/VqXvcag/orlGd4flAH4SmtqTgdt1Hv?=
 =?us-ascii?Q?K3eHrC8Y+cwrLhl1Hzx4/odhcXZDs5DqWZ4WB4JbYg8En1oFH8vbVUzc+4IK?=
 =?us-ascii?Q?IubxZu+fkLIezgkfbm8OKWVSPzKftjFWBv5f1SlKNlkrdNDxrAer54kMeY/F?=
 =?us-ascii?Q?AeLFqV8aVoH3BA6xY4PSJo8lSvnI/GUDNdPWlhBNOElZLNjL3qUzdnIptUTV?=
 =?us-ascii?Q?oc7Y73bl+lD7ZarlRSS2r3vg3hfqalTwwgUpxZpBFZm0q3MSUYOoa559sglo?=
 =?us-ascii?Q?+wKv/+3Hwslj3ArMgIVQvtcSOJEHAM5O/0kt6aG0ipcGZwFdp0c/eQlHDQHM?=
 =?us-ascii?Q?EaYLa6dD1paYN0y+2OxzFwtrK65YNKZtk78161NfGvo0LF5SxadOTAb+KVYr?=
 =?us-ascii?Q?xowmCaygulN2zuVcFYUlUATXWNTEvfX0ghh8nGmdHHTQqjP9ALVROQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0EZQeOPfMLNgt5HdzbmFWhaDg0l4RrCSyVOD4hvchSD9axS/NCN0cAYwjVD9?=
 =?us-ascii?Q?Kp6xS+AKqsQaPhgFwa/OCnthZ32oNUlUn97aD0BUy3VXFziawyGlmAARW+ht?=
 =?us-ascii?Q?2Yj/5TrWS8ucojlaOnFmaoZuvKZPTYXcxDHcoYSJFUT4a230mW+1sNC/QnWF?=
 =?us-ascii?Q?ZSwstgNyJF/UxMMT6dVr9Jha3WP2/R0zyHjZPhjw/T6RHFGsvJ5PXxEbcLHt?=
 =?us-ascii?Q?fhma8FVuaW+gYTh0pXN3MS0wbv7HRipRHCExre5AtpeH8a80WOnUB51lDX5n?=
 =?us-ascii?Q?p4qmk9uKqeu8nwvr6iarGOgkTUVO19agOJRD4Rf4yijJXx3bVOgB1XZCmh22?=
 =?us-ascii?Q?k1QVpUIgHxp6F17DYihTVfNhUfx2FePpbEOWnHmNH2yl4uRZaVwfImuw+EGh?=
 =?us-ascii?Q?9q4J30c5WsOOeY3v++pQzdRvdOmqfHOO3haHvGfVdkkf7lpdQHMK0vA+iohA?=
 =?us-ascii?Q?O7KeAX1BzWH2Rm9gnjQdDutnIJcI2wfn0W1WlIHRnI0t5YCUNJde+KqH+pAI?=
 =?us-ascii?Q?d9zCiWlgon6S+04yAegAWZMWR0E3HM2cZlcOiePsiMfCVqpfyJpoFZkukFze?=
 =?us-ascii?Q?34titZf1ZDIlhV4qzqKUllbG4jT+fyQ0Wd9TZ7BF/o55dKZhULtBSBv5uGQC?=
 =?us-ascii?Q?q/p3Dgxwqh+5LR/+38ku80u8C+V17OiA4vD0eja7wqyHEro5ZOlWPK86TOHD?=
 =?us-ascii?Q?mFaKcYLb7JNL1QraVJDRsrWNEUC7XvkyWaliXaRsIcQqj2QLgnsS9kAXq87v?=
 =?us-ascii?Q?bzpO/6xsOFHIzgSKj7B6VO6k1yqyyoS4ZGu06cb2/jaOvCZrDE9hwQzZ8xJI?=
 =?us-ascii?Q?oaG1W3O9O+ttusGGGMDACOvDYzCPkIFxwXYzErKlxcffjLdhwbOPwKvbL+46?=
 =?us-ascii?Q?Z3mfEgBZSRu0aZ4+yZVOI/a78PruFiL/f5D/Lv3oeYV9R+0j7kEQo4DAH8wD?=
 =?us-ascii?Q?hoRXjHbeIMSuygH6WAuFRni+MHRZO5/+gbQFbWJrV+eeABglPJikHqciGCwK?=
 =?us-ascii?Q?7TWmzmSEvqbP7pRr49rVLT6iQvmx3cAHHurw5QKP4MmnzTAs8blJdhjs7BPz?=
 =?us-ascii?Q?EPg223QG+HIuH5Lz3xrvJ9EJOeFs5XNIZs6HJc0uYVnUcBBmlVs/XETkmqs6?=
 =?us-ascii?Q?pOSfnsVdDWJA4FxjfboHsDtz9pueHvTZSyDdw5WsZjxMVkLiZ3m1EGUoMmP8?=
 =?us-ascii?Q?AtfFxOjjzMxOm7jFZvtoM6PpU7DAaAuVtCZppp2556bMhaK6jM6412w3idUj?=
 =?us-ascii?Q?5PAwPlWGIB87eBCyQ+rQH6l/dT64GP8lCVY8nIxz9X3Yhs8imRAlGaxLf+Pk?=
 =?us-ascii?Q?x55zdxYwFUAgTQEFkXl/hsTzlFBr1Ayd1SPhZPkrgWaMtWyluI1FTNa0K+qo?=
 =?us-ascii?Q?xKTYnQ3JdDFmvJocW5EO3CCB9etbLJCPSHEs96Q/q+tVhsXYOD9djx00Rp3a?=
 =?us-ascii?Q?0qriS6jhIWFz79Q+ENZsQEa7p4oMul5S/JiIIAbBoOMfhYVUbiIcyYmehC5h?=
 =?us-ascii?Q?iWXZ8jusPRNgsJx+rjFmNK/3E5cEywaq0AWQJ4c7Q8AYjZ/sHZ/mUeN0mLl/?=
 =?us-ascii?Q?3JrZDXhQICst8SjDQlQX/q0QCWcSe+IkC5WZdweA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1da7f8-9ea8-46dc-0bbd-08ddda4ef75a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:51:25.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcwX5sDA1eOz5/qv9iCkvzJFjg0hz1BFQjJoDMkNgftVohnIzKiDnXNJtBcKRLAWeL4dqWIx4RjNSmwoyhugig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6927

Remove unnecessary semicolons.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bb71a0dc9d69..43460949ad3f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7666,7 +7666,7 @@ static __init int test_ringbuffer(void)
 	rb_test_started = true;
 
 	set_current_state(TASK_INTERRUPTIBLE);
-	/* Just run for 10 seconds */;
+	/* Just run for 10 seconds */
 	schedule_timeout(10 * HZ);
 
 	kthread_stop(rb_hammer);
-- 
2.34.1

