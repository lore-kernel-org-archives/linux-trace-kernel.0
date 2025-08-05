Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013047.outbound.protection.outlook.com [40.107.44.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFEBA927;
	Tue,  5 Aug 2025 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754361409; cv=fail; b=B6qMVz/HARxGv5EiD1hCChAIzkEGenZqMU/dY4HKN2YvJJohmYjvDKoyWFCg81NDS+6iqXdXfzegNeY/HuA+V6COhXlTN3nozqo+NMhGh+9stgMEkLnPxZUsjDlpgdjM8d3LoPqcau7EYGX96kDm7VbAYKrBg5QMRjuiYXcUhCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754361409; c=relaxed/simple;
	bh=IaasJCVt32Lw9V5X2us+X9O4BuHQkfkEvtNKNVaD5/0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UgkAPhPQx7JBKzigbVdExqITY3rRhOuVE5HCcEvHDJpz/puJ1LAXiGvlEUi2TSPUau5UwSy7z7p92ZjgFojsHRTV/5aMVabvvmzcCmuFwa0CN6AL2LN2HuH0Wyvz1ytD+9J2O7u/g05wNKaBhU9iEFVs2VzDj5kssC2JvRZyz0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bCpKbjmv; arc=fail smtp.client-ip=40.107.44.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bCpKbjmv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNNA7JUpo7Cvj0iMvyXU2xKjDtKCH14X4um95jwwIXI9+uOHGitnb3oHcV5dzYkSfpp9bpEhQHRQRggkEB6wjOtpzXVOvTXZGHROvP4OnnKrGUZQK6izrUwHmLwSmjbbxucLbyqUggut0ljmIEvv5KejBTsCXD7nbq7pXqwIqaaIlNmvyfh3rNw0ZiYZV72V0b8ZcxZwveoy85WpZXLTpW4/6tAS0Avwz5vJs5j3u5uuvrwkkZVuedqLsd/1MNm84/cn6DCsLKEtatAcb5l4fXd83KE3uii91j7e+rLE/s+ps50bE/MP1NMQdOU8yyvZpGW24y0bc/fa78/YmLAW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWA+zvCwSXUTcQVFSekU70dqKuIswbFC6mI9FEZRdyw=;
 b=H6rlFi2MzQ4OwcoKba5TS6BbPv8AGznE2htbWmuB/wkXjD1WVJt+e8l8quGHCbvHgEsw3WqntEmeuyxswja0G93+gKVe+9wVnskj9LyyVOvvGLTYFFowVJxuH9EckLzsBknA+PdDDzrl951Rw2E/S6WRhyVx31cPVUevzO5Op1xkCBvQDh7J+uzJw4vcDRo17nd41cypneCliXNbm782hKmGyiFCTEpSEyE5hCsIdUgTmuVu7TCe8+rz3Mtji6UTROUUQj8e/EpHgT7duISfYyEc+/89evjhMn8AJVZKZsFyHQR5OujldexjguXCQEQ+cJMyMVWTORbDFP78pCqtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWA+zvCwSXUTcQVFSekU70dqKuIswbFC6mI9FEZRdyw=;
 b=bCpKbjmvO0CZYnnMdctka8cf8RE5hqVcbnq7sqPi0BMQqJdgywMvsbIrcRS4lwTdK+LnbLGztFiWBVFOsNvnUICv9RZh0PmkrS9rQWRxfYUnOHsnU0y+VOMbh74cdkFOsCxRLF0dTjLJmzzuz+NOMGhcdTmY62XVA9fWMg+CN9G3JCt6OoeNhEhvaKwNCzdufoWsnHQvRW/kPRbJh1MwH7BTG5u1igoBQEstzpZSwsi229QtfCJz0ASdG66FiVGJwQLgWJI3QMhPPWB3Q0v6CKPcRqYfetrooNzmTy1p8/ee4oak0WhMMwtwuhoiTDn4kj4qY3acIoVnOdblJledlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 02:36:42 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 02:36:42 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] trace: Remove redundant __GFP_NOWARN
Date: Tue,  5 Aug 2025 10:36:29 +0800
Message-Id: <20250805023630.335719-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0149.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::12) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 815c4e8c-1345-4b55-b80d-08ddd3c8e9b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/u2DA9iv+aKph9BsGQiMIkARZTw74LqXO41CBJMjbOEBEePA6Ggp9y3kQc0D?=
 =?us-ascii?Q?shXAzF3KfAHtVLCwVDErmSksfH4cWuQhVHgT29F8ohBDglzjc/Piaxs/hfOb?=
 =?us-ascii?Q?FUbY/lE4zbLJfyX8Jo/GXdDp+WsxUCdeeBPVs9aZyqw7pOgRKo1gsEKBsHSM?=
 =?us-ascii?Q?brmfJTHET6sxKMOd3etBk/MLC/Wm8nVdE745dkDJKDI9l5hu/8lyjeZeRNLh?=
 =?us-ascii?Q?WZbyZp+h6YvIBQOnfKIi9JQSZcKC5lbIsprx7dZSrWiZUwhaAY+kq4o2qCpB?=
 =?us-ascii?Q?sBiIohtK8xgG/qbHLLDXqPLy8vzew/W/v3txWLexXs7huIdFGGlW4uWPjAYy?=
 =?us-ascii?Q?LCA6HoXBqZx3j4+mYNhQksgF/Z44lX0k4D6hjMccSlVxbCV21CvYvIlUD2yB?=
 =?us-ascii?Q?p81bbAtEs31ZbA7rYTSZaA/7CkK+uy1mQXj4tCgwsGdLl0Rdp0yT0Xguut0L?=
 =?us-ascii?Q?hM/S8clDcIZ0J14BirjumqE52IU1ibRw9nnjgJqewKalY4eUk6uYGnxJMm7g?=
 =?us-ascii?Q?exDive1Q+FUwZKuYOd5ddEAsU1OQgY4Nz6AY8qmcnnTLB1mLBtd5+dRMrlh0?=
 =?us-ascii?Q?+UyLtcHqp6vw17+6omYihRlM7JRll4vTocZg66a6zfF6yqXadNrn3Bs4rZaa?=
 =?us-ascii?Q?vovQmn9u9nnpAp7buU7hAlOuYEpEO9o49CtslzOfO6EgSz8GtQUlAWJ6Ot8l?=
 =?us-ascii?Q?bH0Fuk1TZbAe69QUHvoCP+Wowu9yr+BKLCgg3/tun+zOckEcih7ODRls4qfw?=
 =?us-ascii?Q?7XdhpdgVKsmt+VJorh0UHVzVCWzsMgkUUmfgRcr3LFjP18AE1HtDODo1e6Tt?=
 =?us-ascii?Q?nHnGF98VKT9YJRQJyzRvnrzByKFcyp7HT3dehquKkKhRhZgpI4lDR83rgmh2?=
 =?us-ascii?Q?oZaJ8BG7cJQRWen51mUi/3fxEOpCm870JCL/40tLi3I1VLlyoaRoUSfdJL7D?=
 =?us-ascii?Q?yfeYgHnpvEmSqZaeG7ZjXqtDnTc9jQQKxcmCgB+66qdshrqsJDbdbs2PpqqB?=
 =?us-ascii?Q?qfiJE+P17SuYTyv6nF1Yd0ItNAhv6zd4+322n174kGxSiAMlx2ujb3xd9dat?=
 =?us-ascii?Q?JqBoOUfQxs4ynekDVCJc7D8EvZ03A+d2bhpB1PRg539Q/9UzbvkXNuRAT42/?=
 =?us-ascii?Q?ctuhbw92ANne21Qg+QASB8Fonh4zNnEltlJXA2TVB+/KCNDuq6QlVefNquTB?=
 =?us-ascii?Q?Mrd+Eo185qOMuCvzlp4E+scx+b/uCfNgCVyPg2gqSaAZWoTqZJeCi1UEgoiW?=
 =?us-ascii?Q?+bpwQHyKIA9lIK2WK5V2eqaodAyau+LFgsNR4YxJ61h+b97i7yXMDp1zRZQG?=
 =?us-ascii?Q?t2rOvwwXUOmoXoaYF3vY4Wb9RgM7n4ymQ1aKN171OPigYYmxfe6eGKVaC8mx?=
 =?us-ascii?Q?LqvuQh0VZkcMuYFaBgHfX1eesvVCBNuP4ILPEBhJvz73d90NQxAesdkioOJ7?=
 =?us-ascii?Q?0afv2yOFRJzdg0TrfQKeTiDzk86iPYagdIyw1KiQqEscaHrpBYbFXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3soYFL8CvfZxbIpwIZtl2dEJTAt03bjIOzAb7S1pV7derZDYtlz957rJBO2i?=
 =?us-ascii?Q?qdfc1rgzsamQhQQotprahHB8ThgGZJpF9ycLuE+YeUsUX/moYKNi6l7LCSM+?=
 =?us-ascii?Q?Hj8q2j50atz77GTJKFLjvZk2JKMhg7dI8jX8ar08H/Wc48j2oAQkD+XwrBvb?=
 =?us-ascii?Q?B0jkZVbORa7Nqyzj7ITlvACPy9gfZP44H6xhJ+mPsVQPxSrXQK3PPbDnQZvP?=
 =?us-ascii?Q?hPqzw8qCBjcqRTF4cJY85htXKvLbcuzmk++V/RpU4liq1ibaie/vm2C7QGI0?=
 =?us-ascii?Q?5l88KU1sY3GqDmo+OR9HpnblMYrGd+xYbCQ6eHnglOnhL9yUK5aUShMYB605?=
 =?us-ascii?Q?Vszov7Em9zc6I2Cy1dpxAb6DBs+NL0HQN8BrQy5WHTuATzd+Q3/dProEEs2g?=
 =?us-ascii?Q?n+SVBjp9Ym8tdPlIesxLrz6MmB58X/8vdxSvBKillFIm5T5vPlsWE4qeSzzq?=
 =?us-ascii?Q?p5Ec8qNUCLyQLRdQEsHlfz2EJOECIYdvOgXGh6BXN743tK+hlZcN0o7sEKrJ?=
 =?us-ascii?Q?rKSBEPI3/1+jKj4LlatwKcSOOVAO3ckZGxDNn+gMY4YegPFgQ8jKAH8n/6hu?=
 =?us-ascii?Q?H+OxXVcSJr7OFJK7BIU7tj0DS4/6mY2ZwKM+eD0HTab1IvzIHorppM11ZIpc?=
 =?us-ascii?Q?mxAOpA/KeEkPOZ7oVJTpvUKrKj2f8SiW+1+r+sgjPoEAr02mABSMfz3Q2az9?=
 =?us-ascii?Q?zSle1R7CAX6j053siL5iQ0Cr9FFRrUFaC0EbMD6wBVlJj+RdKxPRQIMsRnS4?=
 =?us-ascii?Q?vN3MrGCRsjHsOc7AiOHTBvaFDS1jRUbNDPlKZyKbTuAi/qCNTf9XE6IIXbkT?=
 =?us-ascii?Q?a/rqJKoaRSFpsG8xKk9RqW31ukBfVJ5PzKi1An0WrF/G6hS4IQrZ0ylQKQyy?=
 =?us-ascii?Q?8LUzIDtn+8mkVl9bLsxWLRX8I/BfXApOADtC131ojWNjFMvlUwD/Nd9RgCgr?=
 =?us-ascii?Q?+SozAIhbd5Rr3yTuqoorwZONQSq/Mr/2RguwS5NEQajJ4Qx++TgZBbxaK7e8?=
 =?us-ascii?Q?MNU0fUjB9Xyv1U2fWoTnO0W36FyExpseeLFlCRnNLhCwQNZbkzGE7zp8DLGX?=
 =?us-ascii?Q?zxUpgFIjX+OZVFMWbmWr0YdsXWy/UmZGcxAHnmslEt3KBB6jKLb0JFnlBUii?=
 =?us-ascii?Q?dj6cXhjlapKkbdzeRlEQuE5zqYSOkT+BCrrN6bGZaN0oZajpYRUefm77fB7C?=
 =?us-ascii?Q?HJPUTFE22PJEbcm1B0YnKPmJYcckM4t10sC2QI5d1ej/Oey7tFxhCmmDrt/1?=
 =?us-ascii?Q?vCEpYCpAx5f8mcM2kdDJPzppdmt5BQtnr8n++2DTv2F7/QfwRPXas3r3aXLV?=
 =?us-ascii?Q?a+Q1yilWze5eGC3FHkwqasJYvAwgtKfb86owUWiVm36xWtys533BhUlJ/CFK?=
 =?us-ascii?Q?7SON1SNwLt3/ixcfhx6ebcLAdnMgv+0UdCDdOjZVz/pYMdV42LgZ8o2OKfPu?=
 =?us-ascii?Q?ES63rRchv+MSddxloCm1V8aKpgO0IivmnOy7nwRXuOPk+kileSn74EM1laKV?=
 =?us-ascii?Q?6uA0BigDZg9sjiQpAYgN9KThCobZP0+rp5u1JmJxdfNU2uEJB1eGZyFQ9KPB?=
 =?us-ascii?Q?dt+JS+AfzvgBTKp8o4A3VpU/CEXGwLs+CXFwc54Z?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815c4e8c-1345-4b55-b80d-08ddd3c8e9b4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 02:36:42.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44919ZTnjLtZPE9YoYm+fvD6YkTY3WgBPVLpjKFJEBkYNtyEBulWLN8/pxP7vjDJ7gIofr5d08drR+B0KcY0dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6524

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
made GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
up these redundant flags across subsystems.

No functional changes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index af42aaa3d172..2ab283fd3032 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -496,7 +496,7 @@ static bool user_event_enabler_queue_fault(struct user_event_mm *mm,
 {
 	struct user_event_enabler_fault *fault;
 
-	fault = kmem_cache_zalloc(fault_cache, GFP_NOWAIT | __GFP_NOWARN);
+	fault = kmem_cache_zalloc(fault_cache, GFP_NOWAIT);
 
 	if (!fault)
 		return false;
-- 
2.34.1

