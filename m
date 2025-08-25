Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012066.outbound.protection.outlook.com [40.107.75.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA812B93;
	Mon, 25 Aug 2025 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125135; cv=fail; b=Mx5iHrQT8YBOpMs+DKIPSqjk/UdD84pr8807JJlLZsrkbZm6w2+DPuuqdOL2gqjazp8TAOnV79NlbBTZ59eURrZY9rbnoMqw/qJFs+LAo3MN6s1Tvi+uRVKhctPpDjlIkq6PuE84rT4pdYMPX4TgQX9Iu3qhtX4VAswOcbudOdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125135; c=relaxed/simple;
	bh=Qj8jg3LmQyY14rzDA7y/xlIK7FAA3/aJUYUxPsaNGcs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fX6SxzOlp+8k8N6BJvFriEN4+FJZ7Hx4KaD9Gc9LXBDXxnKM2tza8/7FbKDL7H6zryDl9Z43jNQhAVSr4HeW8FmIFUcm49Cxxg8KN3DVPvxv2jXqLE806YsBD3c+AmmT5xtBli8WE9nsI7oSsoJp/UrYThQDi7tSMeqroCtn+08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Fh9hiEWt; arc=fail smtp.client-ip=40.107.75.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Fh9hiEWt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdWU+oDwF/cYnXWP7/jBycyyl7omJQDrpvdr8CMaEtG7YXI6f6wjBw51/yvhqhOmYQxuRMGa3pk68hrRkWnplNb3X+FALK4J4I5CzSyHmk0skSBX658Je3eyK2YObwbmIIP51BXMR8/7iPrt6QQ1L4QrtDo0aHAPtCsfqAM/R/Yn6dnP1CEMcs7eM6YeBeqRVCa+AApCfnUOwcSxbKyy/7eoWOBh1brEkSn2AQokTiDc9ar8j0/TmIC++WGpjEKBARPV+g4XvBEI5G2TMiQLq47F6uCgpSq5FpKRlIpPdub0c6Xvd0xXmN7yH9BAYShwRaGPz4t4elDDrejvYiPzEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiMYVOKEaPsgMR4JmI1Dsqxl5dWto3NkeEo/ge7Pqzg=;
 b=rzRsGKLjK8Gz0kiTssY3L9wp1w+DTqtQCvwrQk9lZFo+SD65/DB8HUTSsUib4S7byN6zzy15P4MexABjWmQc70igd8chkO872GGzqKHLoAL3IuqQBcZZMAS95tfm3bA5BhD/w6yINwWvYsfH+eJGmzrJ3ml/4/BI/q3nKoyO+udmx3pKe7Fxvzzp5J/ocHSXACAHDvY+VBe0/PjAdt7wGsdclBWopEaCbR/f5NyooD8mALeFTjwWHaT8gpJxueOuwjUtpE9tu/nx1xE6TfFFQNM3r/b6ku6Uky8jCyTtH0E+wsc7mOIZnKgQIBVXXJvcOm9h+U7YL2dOQkFu0/ES6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiMYVOKEaPsgMR4JmI1Dsqxl5dWto3NkeEo/ge7Pqzg=;
 b=Fh9hiEWtL6hvIhUyJ7oMz9974PHtQiDeSnNp5wVzWiKaOvMTIWgd/xDF/HztK9F80YKs2GERkN22diBQhCNGqCbZJE7+ICpaFLnac2juZGjCiqAUqYIPLrA+3Ylb1FWAOW2TC6S5dq3lqCX2K/42QJf0Q+SkE1EoijouaJ1RmerQzoKTH3UEJoekhxFC9wW8LO5t4BC1zpfLcXcuvCzOiKQagmWhHGhRYCBycxM6rMKlvV0hsHqxqVrovHAiwwNGkHHFnJ7+4jdgjjgulP51guRd/4LtycsbqNoLrq+XccimMhwVYkjFjSGZwdtT7kmq8dA050VxbHm6gIAzsLFHJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB6623.apcprd06.prod.outlook.com (2603:1096:820:f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 12:32:11 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 12:32:11 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] tracing: Remove redundant 0 value initialization
Date: Mon, 25 Aug 2025 20:31:59 +0800
Message-Id: <20250825123200.306272-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c97fa79-aece-4eca-319a-08dde3d369cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PCOTIgy2pHIWyKw5qiU2yp9q0Lf5Yv6HmhxpUhzZxzE55ssfNo+nTZZ9c9IM?=
 =?us-ascii?Q?74syMc3lP1BUlTblxkJQlFvQQBNzPm7qJrqJLguBTwSE9aO8gsd3M0hNS3NP?=
 =?us-ascii?Q?5eK/GRZaN3o6YY769/cymJB9vxzpUctczfYNLY2S0sXSJEHH7A14f00uv4tr?=
 =?us-ascii?Q?xvvU5lflZ7NSo93iehDP6Hjex5zvhplS+x+Iv69JO/MqGmu6CamNTRktzH5v?=
 =?us-ascii?Q?nNE8HlW8V6EGCxJX9Tj/tSbWOwEb3vaNQPw/9Xxhk4IkJjmby3kZAVvSmmcf?=
 =?us-ascii?Q?VMtmBA7/dlePzpS4GN8DSBKTRXP3eQb/kQFnjUUvdOD1NTxN9+lrbY/FS2br?=
 =?us-ascii?Q?DFT7dJvO0rOk813EQZpDcwkWMFFrb8nohulO5579OEjAV8mzAXuSLeNuiFuJ?=
 =?us-ascii?Q?dhAlJl5KeByA+9bRodJ5Ry7dXN1DuC/e4ZjpOpd8Jr5M7fY622SKqpY4Macy?=
 =?us-ascii?Q?AYPWkGSphmtSonCs1sMIUjF9s3eVDRRBD7lcdF/60y6Fl4el5ly5X0lRdbxT?=
 =?us-ascii?Q?MnRubt2Ngh6EDqpyDXac+MAj6QmTbSlv2RGM+fZK3BDV7SXNG3kWQYfW1LNO?=
 =?us-ascii?Q?RiT32fURCoi67mCWNa/0G4d+xGjEkFunw43KYDF8B/C2Yg6ne+pBKcu30D9v?=
 =?us-ascii?Q?bz8rCawhnpV7U/nWrckSKlaDJjT6lp0aKbHJB0FeX4OyaDGCclAZ1AIxu+pD?=
 =?us-ascii?Q?jKzaWHLo6ByDFF4Q3LUx5mUUp084C3LuTpq6jKEfh8SWbOQZc2ckPUeLKD1j?=
 =?us-ascii?Q?kvP6QUe3ekIB9veFBkTQhe2bDCc5nzzvQ8xtTVXx5eNpH3NaL0BKFe2cTLb5?=
 =?us-ascii?Q?hIUtXdC14n/Ohp17f1XRNTP75h9eq0Ygqq1+DleYIAXWeVi6CaXE4vTUbb+X?=
 =?us-ascii?Q?CFGsFQxujADr1YpFHb5XxX7m7eC0bL6gxseqm8ikNwpvzFSB+r2//64cjp5E?=
 =?us-ascii?Q?G8Y4Iv8hTyWwMEKzCX+HFj7HuqA/bUNYHGTP/kGB5d8FANG3WJqJpoWG6Ymc?=
 =?us-ascii?Q?oyk/+XDoc89lf2wkqowXKy9pCv73eWw3E/MgZA9uETOc5Ok1LVm4dfR58y7n?=
 =?us-ascii?Q?GtSz0qWc5nH7wIYPNknfJaRqGZtPuAC304P+5Bb+C812AuIIMWHddO+rOlVc?=
 =?us-ascii?Q?PY2IULhyKJCbC5BM/7dYTTqYmQ/b3jq7XnU7O78QY+Asy+6UKVEsy4mOcY7F?=
 =?us-ascii?Q?fae/KLjOXm5+bsUj/HpATRAv5f1o4YUdLxne7ODkE35LDhP2DwVk+nQ1ASkX?=
 =?us-ascii?Q?nqSymLgPA4CqXQrSNHQatJ28evFplfPpb9qNhJg0JSA6yQAxtiEHzrdIMIiP?=
 =?us-ascii?Q?MzAdurap8Scs2wIke8MhYjnHjaqreirrPdJaHcE+tZzkXJa33qkE4xqSUKMq?=
 =?us-ascii?Q?e7uxsyX4Apext0RMgRcIwIrQX8nzN0ksNKMetrMEAWmKHK08+Qu1koxap/Bp?=
 =?us-ascii?Q?I8kxYEJDG3VVQ0ZqgyOvQQLBzRtiLm3AlkOUqKdUcH1tfE1+JTYFXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KTfSBgjckZ5Lnxzbc0lnRvpz4y9IWes8C4E1ebHETF8dkjtSg71F7rH3rtBC?=
 =?us-ascii?Q?aLX0X2b/dM6ZDaAv5ExWnaVdeRzPuCQVfdGjx5UyNfUlxQuFByMzS1elNmQe?=
 =?us-ascii?Q?mogd8xiGijxoZ32ZdbHSjIxwiFzBgc7k9dFq7xxHiDn1f93EK4HUk+HwqoF/?=
 =?us-ascii?Q?PPSDjRr1f2Uepcylrz+wOPmlYWgYuyBd47Q94EyDNoga0PRxQ5N658QCnVea?=
 =?us-ascii?Q?seL/B0aReg8MF+oRwx0Y4f7Sng3IpZ8+WxyHTSLe9SIVFOu1YSTuX7rBfy+H?=
 =?us-ascii?Q?9oImGueSU3ZYRVBbXxhPbpGC3X0PbIlTKgG7cQl59hSIIMJj7iDh77p6eVVl?=
 =?us-ascii?Q?bQG8LP2qBpJ3PY9doZnPd6MErlCk5Jtf+ohK8kh6GRaptdHVuwRPobRGZDRV?=
 =?us-ascii?Q?65niviCaMBXgrnQU5qdrAWFDXsNIq/ypbG5pad29xhV9O0fU+NVzNv0eESdI?=
 =?us-ascii?Q?4pSY/J5WuypUX8IiaUj1rw2ZqEJ8VdkwouAZ6C7Wjq6JzXz9tHq2TfDNZGwb?=
 =?us-ascii?Q?JVCRKK7jDrVnyBNvsXnb6t0cUcI7b4ua+tfaeqlst7R/VDwPxkIhjJzCZq+o?=
 =?us-ascii?Q?hBE6ypWclihBir3it/o8apbZ/Kv1bh09y0qT6XvXvKeEymiYyW2ncjWeYsQi?=
 =?us-ascii?Q?ZMj9u933QkPLiId/+KAN6lvAG8RQSYN5EboMv/9yRXbd+lOt3Xq/xTPOIHgP?=
 =?us-ascii?Q?gVLEGgOSbBZqxLOAvgc5IRLFasqT+w3MyLmFSmHqOSSNADMFiKlOWKFZQPrd?=
 =?us-ascii?Q?mz5bo21mrx56rlx9rao2KXUxmyjmJLhl04hgRCYEmJOpo1oiRpaoRjsn2vsC?=
 =?us-ascii?Q?3xdvcZXwzeFPkocfMqzfpa5dWQLLLBB8zc3bd417n9kG5M0JF+LC7Cbf1HLL?=
 =?us-ascii?Q?zuKTHhXnX36ycz/MdlgpRKp62x1ObGV9Ei6EPJX40AmPhV9K7ahaTKVg540z?=
 =?us-ascii?Q?zYwBxqjL6eCXu2yd1N3bzaqKHh54dn6xiq9ZcKgllKTw3JFb5twEu03QHhNQ?=
 =?us-ascii?Q?+tpZEXmCF843Fk+HOprj7HyOnOw1I5TAGOyPVinFEqGUnH5bkmckBGjDV4BO?=
 =?us-ascii?Q?CVzu01hQGlvq+sQ/GeW2nY4D0w8BIw5LIVbVoqcUDqa66caOSmiFCpwqnF+C?=
 =?us-ascii?Q?xhjIBmrV5A95McUJG7m0AzwQyyANdfNRxEa6jHJL02TTIStIasRQllxkGxNg?=
 =?us-ascii?Q?rsbZyeAVBPoiHeV9XmrIMXKsUKeyOKW4RrbED9iQODx2fJmzprcXuDur0tfj?=
 =?us-ascii?Q?N+Ws2U4sUQF2msvO4ojSKcjeZv3jZzxw//Q2unYhXIyGy6qcGrtuPJKvL/lI?=
 =?us-ascii?Q?J7zslTHPRdoeI4v6I7p1V+YBYU0VYKUqjW1wc3Nt+OTHojslYhJ4eX92aqco?=
 =?us-ascii?Q?BVK7hV3CkjlULkr+Y9abdbPHanHEqXHe/0qv9YQQFZhWheuC5w0CugxAqobq?=
 =?us-ascii?Q?hjOtOyiTWPSfEhzptOZy7RwXz0WSqqanvT6+QLLjpy1xfjiL0oyvgsucDs1I?=
 =?us-ascii?Q?A8SXhGzgmHGn9+W6IDnvPyWvG4VlFvqkIaFwsorzdVUP8roDyzrSEcR1WL7b?=
 =?us-ascii?Q?kiV7YB4baYPkkd5W5bQa/NITTBoMmTcee+SQceQY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c97fa79-aece-4eca-319a-08dde3d369cd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 12:32:11.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfitJa9kVZL24uS/SaFBuKNh5eu/0c+cn47qT/1JWBDtWeNrOAdwywYGy7wdUQAzzywR9AZMIKHQriJoZjwCJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6623

The saved_cmdlines_buffer struct is already zeroed by memset(). It's
redundant to initialize s->cmdline_idx to 0.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 kernel/trace/trace_sched_switch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index cb49f7279dc8..518dfc74347a 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -224,7 +224,6 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 	/* Place map_cmdline_to_pid array right after saved_cmdlines */
 	s->map_cmdline_to_pid = (unsigned *)&s->saved_cmdlines[val * TASK_COMM_LEN];
 
-	s->cmdline_idx = 0;
 	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
 	       sizeof(s->map_pid_to_cmdline));
 	memset(s->map_cmdline_to_pid, NO_CMDLINE_MAP,
-- 
2.34.1

