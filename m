Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784105;
	b=CHpvqgnSQVxSn98omSh0v51gRHSOZV3nNS0NAKfGbMBEEf7shi46H13IZjmKONePH0u4
	 KkIT1YfQFfXI6NTw82d72yUL6GvKq7knmZMPRDHk0EbW+R8A+/+SZz72u0MAki3v7nB24
	 3YHUFXWp/cdv1JefCBxP2mgvneLwa6e9cl+Syk7MAveT9bB8eQfb9XZFKknC1xoM2HZt/
	 j/NixXKUxJOb92fK//ESWppLhWy5+oiDaHGOp5sPeVJQItbNmIdiZPI2Y3D2m/UNjxn3J
	 /xN97yymqVtmhstGg2WUmTn2PMdqb3iThaccSgJRnKtulqAejHOha1uGz1GzjWC1PYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784105;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0bJ4OuiBnESgSwiUCvQiiceeTVlainiEcYcvRzc+uAs=;
	b=ebSG+5tfvKSsiTagv8H0ebEixC4jLAo8tj2KAFbffDqnuxzm105EVenlLb/LUWjd9KQ4
	 OPGGIgdeyYfW39ivijeUM+vRMVrWw/N0m+8H/l2ohKwoJhfnVprxVwftbvtvYq0ZhqGhR
	 cFB78M+lxaEPgjqbV5gc62qZ3TSVQzrxf6PNLHWg7HNiQ7E3bEm283U7vVEDhnUeLqZpf
	 rrOQbzcmOPDNGeWvAa4+NsJTlXHqbsQlAme4RPeb8NRZdBsfGK01TNb8SyasMvr3NLHmN
	 L9ywSyDz60xI/R5pogPXvjeXzZMxk3S8pn7oytb3wA80Q6m/dTNZ8FllHteL3d5chqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b="K3/Cfxlw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.14
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012014.outbound.protection.outlook.com [52.103.23.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4458D606A328;
	Wed,  4 Nov 2026 09:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4458D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=K3/Cfxlw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjGXzxhvMGUgGLCVQKuz4YYULRzcnG5cWVKpG66NQGnRZPmk2MkcjajJVqYZIbZjtmvcFrX2qBxiQcJRLqw9tJp57ewv31ggFUGdWudJiqLQdk9Jw7Yt0UwyGHfcCFlvvqtbD2V6fup7wDRIZTIdI2YbuxpUsz2ymEbmLGjKSE4zZ+MMR6YNImwEW/c/rFWmx0Dgfc4rv1c9rRRl8YJyYkIfVvPnmkZTJkUI/EUQ7neSaOo3pXTJK1XLY7EMbcII1TOHE8iilmt5EWvGX1hyZGERGKdg4FDiReh64AuFYpZNC3PQQ6EQubfy2U5ceRDI5LMu4GtsbJvfTJPG4+Fpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bJ4OuiBnESgSwiUCvQiiceeTVlainiEcYcvRzc+uAs=;
 b=aasHJ2fBJ9anPBLGqdeGw2XR9Am+mWXrYw6a06WKiJqDj5Eax2tD8VjvOuk6wdiwXKNtqkaTGIt8wcPZ0p+UNrwSkeJTwVrQ+qSuEcCoMS5h3HazZPJl+LsKrghuAdpru1ipYFpsEckZK23eUbWCw/l3jWoA7VS97yem5RnM9yTx9SclZnZUJLtqyw9wkKPzGxpybU3zeQe33eZueS1PaVPOJ6rckbATrRBkGiWFveU3963osW6yIlifVYbWaqKJPD6ztdkZl7/18RJmUq6PTF+nW9ySUh2rU0k92NWPlcLPuHL/4Duotinnd3dAJbYV9s8mgTuoC+HRxPLY4rUkLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bJ4OuiBnESgSwiUCvQiiceeTVlainiEcYcvRzc+uAs=;
 b=K3/Cfxlwbpc1SXhUljVa61Qkn7ZfBO5tWXeJpRVqTCFnLxdtViqi2gnhZiJ1mCD8QoV37T5uQtNzO2P4FdUpqK+TQKr8UO+jaErEoEf6K4d0xcGodgVocts5nogvqmCeSxCpmljR+ywicU6vTJhP2NDbc4Mh00kuSLv4WPn4/uUIju5YbwiZgK4SMugERhoK2Jm9g0C/R1Z75usxBXejPUAG+/1knKUMn4D4atMxYidZZiW4JTs9dKk23Q/beZqt6RmzOBZC0YsfoMIjzJcIIEemXsrnpRiUv8B2Ucbkq6lkFgmKMGppxLZrLQrWD6CTBys7Ek/fctY53SWTezBAPQ==
Received: from CY8PR19MB7009.namprd19.prod.outlook.com (2603:10b6:930:5b::17)
 by MN2PR19MB4063.namprd19.prod.outlook.com (2603:10b6:208:1e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:21:43 +0000
Received: from CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb]) by CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:21:43 +0000
From: Wei Li <liwei1412@hotmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	liwei391@huawei.com
Subject: [PATCH 1/6] rv: Mark diverged child reactors with a star
Date: Wed,  4 Nov 2026 17:21:20 +0800
Message-ID:
 <CY8PR19MB700998CE5DB06F45985926E8B7682@CY8PR19MB7009.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::15) To CY8PR19MB7009.namprd19.prod.outlook.com
 (2603:10b6:930:5b::17)
X-Microsoft-Original-Message-ID:
 <20261104092125.915254-2-liwei1412@hotmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR19MB7009:EE_|MN2PR19MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe8638a-d0eb-41fe-9a63-08df3a550a21
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|41001999006|25031999004|15080799012|24021099003|260925184616899003|19110799012|51005399006|8060799015|25010399006|26104999009|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oMt+XHp2u41xq5jmfZJFE7NMdCmRAQEAyo+EEHYaMW5sj4hTV5426GuYnOHX?=
 =?us-ascii?Q?/UxFxTx5gcSm6gFd/EJF0IYEvjyMxzGxCrjszSCek2wxFN43KOWIDhqxxl1X?=
 =?us-ascii?Q?kmhlMJaHtMEcjlXZOFwWl1CBhlgvZ95aklcS/cXIuwve7PuMwfLNQLPX3+Pr?=
 =?us-ascii?Q?7Un5MBZ7XGEnxWVbQwft6l0ajh+S0KfjLbiUwVjseDeCS5Y0fnwp1KQav2Ht?=
 =?us-ascii?Q?g/3m6BZG2IZLR7M8OkH9FaBTdRj0V0ogmvKmrClEhpOpHLIne+Z2dEnycHeh?=
 =?us-ascii?Q?Cr/xf38AAIMTzbVMtA9cpNAaElPaCwhaXHKuFaZ8IOr1gRcK+YH/Xn8FBQia?=
 =?us-ascii?Q?Narwj4pDPnSrj9ppzpqqkLxXwJRHytjri3bcrOr7i2mGPSpw9hdA6UaUdKpE?=
 =?us-ascii?Q?r4xbEkqYgKH9yxFNmYYqY7UVzYe6jGNqAzSVb2/VgO2L3yP7xf52NEEj5lGS?=
 =?us-ascii?Q?kclg5dCnRLfyWWJANHRBECaiSDWRUQKXlDWdzwRxpGjNLsb0pEHmdEbefPy2?=
 =?us-ascii?Q?4PMRLozuIVmIO2X4c5NRAr3jq4TXIrcXS4gblqX5MhxosZESOGa3A7NfbM/f?=
 =?us-ascii?Q?9sP2gc188t+kq7lLQ/Rkyg7bbv5QAmuevGwqXkQ1pc8TZGo1f1HaCJFSOFMo?=
 =?us-ascii?Q?ADaJH5RU5uMG5LciKBhIb7IcOM3Cl8sBO07WSlT2yI2Z2RH1aATrJ3y3csa5?=
 =?us-ascii?Q?Aj0bZCKuqnaBCJXL+1iAVYj01p8oYJoHy6jDFVTmPJazCGJm3c17+cuSfjkJ?=
 =?us-ascii?Q?QZH6sbsj0r6gYbiUPZ+ujtdfiR721hDWJ7SSckPU5K7/i4M3B20rj0IdeFXl?=
 =?us-ascii?Q?/I2CZcZ89oq/DuDfddvs2C00VVjU52eIqzEogmC/KJ1ivEg7nYDhIuAABZr5?=
 =?us-ascii?Q?qdsM8kVbUcQrzdBjITChOAd7uXswvIdrUlOARMt634tBQxa/zEtppgfp3NFY?=
 =?us-ascii?Q?N1p4PZ6JCvahtW7Uss9DnlvoJRXY2y5MAsTG6iTwVoMqXgr/6TcrvjDAeDwM?=
 =?us-ascii?Q?zdMj?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/u9QCWaQniqesUEKGc2PSYaoz0BnDVsfkliMdBd00SEMdJszff2EjdaHYdFC?=
 =?us-ascii?Q?+GeDNRjomqV4WCX5dWZpLTW+U6ruTunn72ZRvsrNGgrDPhU1Xcrikyf2DjJo?=
 =?us-ascii?Q?x9nrP0GHU/fFziXZcUpYmJJwWjNxBXbaOn98SkW5l2R4PIOh+MOHC4IDvYDw?=
 =?us-ascii?Q?fzLZpTHPsGxFsTETJ+jTQCODE/dnpEgrBfHGChi0XLhyRsWEQzuOPAUGzLeS?=
 =?us-ascii?Q?eJAi4Y/a9DXmxdbpW1i3ED5jrpTclEb4O4urIu3SpPGtg2r/xHvbrG09fOle?=
 =?us-ascii?Q?jy/Yah5oOngYzvJUKeqe3ehcQEFDI19hnHvbKFArbDayZrDhrPMo+s4jb8IF?=
 =?us-ascii?Q?HGB6y0G0yHOuijamfJEJiPpUcJl+XQpJFkdJiMGZYYEpvVWQtLBgESiS8eDK?=
 =?us-ascii?Q?w40WRgL6zD2gO9LpGbU0oXQ1HR9/7ZxBs03qwpVc1Is7UQ8tTHG2ih3ZMV6F?=
 =?us-ascii?Q?grVtzKHq4rEQTva6BPV+cMf+69DMVr5VGf82TqFzscL4SEKTlm0veyBIGbe+?=
 =?us-ascii?Q?sWIghC0TCcajzsG5yB4a7ISwkkufKwBC/4WJqrTtLmL4Ptw9ijioJFzkZFx4?=
 =?us-ascii?Q?W2LlRCsp6DzCqUrmAotvL82D2WKanzNknp2bXbOQF4ME7YskwPkAqiTMZVLL?=
 =?us-ascii?Q?OgaUqxCpfouW4YpLCp+gpGca5Ixk8e7R07CbxoJPJDlRsnYJ62t99PCTDgAv?=
 =?us-ascii?Q?ccFZwxXBNztRdNTHv7T/Vn20bkdkuVCvTPXwAlxnee3jtKGUgz7TL7RMSVxj?=
 =?us-ascii?Q?lMTRvO13tLA9n6Suob95WFx3Z8Hmub66cLhm0ZkYOU6u8Pnmurylx4FM69gQ?=
 =?us-ascii?Q?Lrb34asNg1xkeGtvNjD5m5YiP3DUFx5QZyWn+qsm+3xq/M1K9AT0Xk9a/RIK?=
 =?us-ascii?Q?xn1hdoAVd10B4RxwlQ3rHckyTcmwRuA9oW2VBxHtnTxxA0UcbGcoyPmGc6+X?=
 =?us-ascii?Q?a1SIeYH9AEXouG/WDBP6zIqqGXOCYPcsDxDd7wwn1EFQ8yPMmmj/TGZVwSlj?=
 =?us-ascii?Q?UrzKuk7foZ+XsdH++9dT5fMbSBUpfmWCi9gBvktV8aV9J4Ojzy70nKQi/xZs?=
 =?us-ascii?Q?5UW6QPwtM0SuTlK/Mul/VgtBlNP9/M/isuzrLSBPlGDA8cmb6jDQQZWWUKf0?=
 =?us-ascii?Q?I9365JlNwmMGMsXEJmKZP3ae9rOFZfQHyBEL+o9ClNhbk1c7zwsQm+s0M5Dp?=
 =?us-ascii?Q?BRGMx8d3mIP1T9G2oGnoZcbsjgbj4c2ijzMWTUcTF0XP86syEheHQDVHBBkh?=
 =?us-ascii?Q?YOthUlD4e8OI9HO8lJVPSbY+8q+GX1AKIGoMLVp9q6AiAOTP0a/SVliijPRt?=
 =?us-ascii?Q?Z3CcgUf375COF1q0gQbGh5BeJKsI2tcl1trDybwdC+0sF4wWuaj49m7N4eYv?=
 =?us-ascii?Q?73qVzvgTJ9poonINIc9ePBeSbjqS?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe8638a-d0eb-41fe-9a63-08df3a550a21
X-MS-Exchange-CrossTenant-AuthSource: CY8PR19MB7009.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:21:43.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4063

From: Wei Li <liwei391@huawei.com>

Each nested monitor carries its own reactor pointer. Writing a reactor
to a single nested monitor leaves the container view unchanged. The user
cannot see the divergence.

Print a "*" after the selected reactor of a container when a nested
monitor uses a different one.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 kernel/trace/rv/rv_reactors.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 8e57a95d446b..ea52f50e6453 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -134,6 +134,21 @@ static const struct file_operations available_reactors_ops = {
 	.release = seq_release
 };
 
+static bool monitor_reactor_is_dirty(struct rv_monitor *mon)
+{
+	struct rv_monitor *p = mon;
+
+	if (rv_is_container_monitor(mon))
+		list_for_each_entry_continue(p, &rv_monitors_list, list) {
+			if (p->parent != mon)
+				break;
+			if (p->reactor != mon->reactor)
+				return true;
+		}
+
+	return false;
+}
+
 /*
  * Monitor's reactor file.
  */
@@ -143,7 +158,10 @@ static int monitor_reactor_show(struct seq_file *m, void *p)
 	struct rv_reactor *reactor = container_of(p, struct rv_reactor, list);
 
 	if (mon->reactor == reactor)
-		seq_printf(m, "[%s]\n", reactor->name);
+		if (monitor_reactor_is_dirty(mon))
+			seq_printf(m, "[%s]*\n", reactor->name);
+		else
+			seq_printf(m, "[%s]\n", reactor->name);
 	else
 		seq_printf(m, "%s\n", reactor->name);
 	return 0;
-- 
2.55.0

