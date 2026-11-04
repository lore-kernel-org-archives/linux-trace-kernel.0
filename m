Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784101;
	b=bCeD4Kf2LNGmzKSUDoWlZlbhwlCY3jFVKrsDQ9nTVMJY9OQE2Jo+zrm9nFCj5o0ua2DU
	 F1bIi03bsgicFlC6dmYKlRkWjP24mVoBf/D70cJyId9QRywOL2EJ+FMMcetkf7BYXYBHs
	 0+/Kqvm8FpKyEqMTY4fkzlCQFgwZVlfQDGhruMRzNld/Qw1qEqMKpD5G4Q1XoI31rOZSl
	 XZclH6VHQZrxsEjKtOzTe1AFhqxYpqQUkQ1pK7VM4IG6TJTQg4dp9UfV+uXD5qq1xkiTf
	 UI7dirgKBvMt+j8pVgxBFEE2tH2JrsI2Xxr14foDLCIlDrO5lZ49mAqza2ATI+3BTpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784101;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
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
	bh=Xn3OQH8wc4bzJ74VhVP0aSk+SGx5N3XpFJuNKNLSsTA=;
	b=F+DTTIYautwQo+D+oKYNB3qeq1G+7nzA3mqwTE7NmfmugaEleK1+mtjEGDVmLtJcZIcM
	 Tcx4y2V1uofl/nqbwN+BK/OJ45V+QlsJ8WaT5ZdUnLRznmnm5bliDH1pIMv6DLTl52Pwd
	 SzdEsbWgxdSf0Vz1xwqZL6j2p9V5F6jCwdzX3owa0pc/Bm64kmJgq+uCKe0DSNriVrCel
	 uNcPLfT+HSCaZb7i2DZ2q9B26AIvkFnzQ4Z+uvG/PTVDiosALkAHCo2w/C6jwJ0m6rtqC
	 I2eEKvGLSXB8tjm8tjh/ELCGKmxbIFZknY6+WNrEySygD7rTiE/zGwfdJ4J/MmNS70A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b="KS6H9/pb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.58
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011058.outbound.protection.outlook.com [52.103.14.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D741606D81F;
	Wed,  4 Nov 2026 09:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D741606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=KS6H9/pb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlDf2C84nW8xp6qMNTjUHy3nWIjVXxYsumvFFg4qW3L8uVYOVGv8qR1fpKGFcL2pfsN9n5FyrdGC80z86xwj4Soqk2UEZamul/eG6RUdu0K94fV6oP6EzOBIF58GRiqAIsNNWO+W/rUC9lqmKjsu9kiG7sBRvRjojqbjomO/OIyRdNyTnnDWrXanUFGSD/s/evO9eLZdaUDhD/Ey0D5THQpUA4/DMKCQWbWrL50Nhoob5nK471CCOG7RpOpcC8e4fI2m1aCr7v8SV9whwVNNulQfw/oryPpcqS8CV4/fI5cXPO2j+OtAbRxWR6chG+tJE6eQhI7ppkWN7XMkVPCPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn3OQH8wc4bzJ74VhVP0aSk+SGx5N3XpFJuNKNLSsTA=;
 b=TLtRaau9ojEepOJShfs9Vy8Y2jnSWla1OhiTRS2mHSpr5fPEN85g3RbIRCX0z8rVa6YtzLC2MGc5TG/g5HneOC2Do/XZJSrrYZRHLifKTF4yWd0qN4siRkJjvLOGRP7j6y+RN5VPed1hsdEvnaJyiYi9jGVGhx+3C0vpVlf7+ryo3DnZWHEmrwBHgeffdOvL9FbTt7AIWR9vjKzErKQny9jQRuXpEwH0rkdmb7d98/KSGllL6fCHxbGIXemXm720hs+Xrb79gwkOZSr3CEvGLL6MdH0lpm463vte7F8+uQWO08Vq41tyvYdJAfRJJ6fpb9DJsXzNoRpE+Sn47ECfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn3OQH8wc4bzJ74VhVP0aSk+SGx5N3XpFJuNKNLSsTA=;
 b=KS6H9/pbhRdTwthjOcL02SXzFeajhebTw7+aNSSM5tv+ctJvJyBv6a3dItpOXqnqNqPyMSPocVMTkV+uDy1Frnk9BPzdX7w1/LmNTGYsmkvL7rMMQfJfo0K2KnNJsyN81uKQSELSD7GZOK4wn/aHKMM5veNgm4SwGK1/poM8jxdRIBcP1dgq0TGiGtrnKaWKE7x0lGrjHTB2/aCGuGLO/vBMIO6YHzBOJNAo7ER1NHwGeXkF9oOe48YKcZSpJXIsL949NnBl5ghC+kpBjUob19tngjh9PylEkZKRnKtYvgqVCj+5nGAglBhxaljTyPYdiGXYH5kt/BDd/wLC/J82bA==
Received: from CY8PR19MB7009.namprd19.prod.outlook.com (2603:10b6:930:5b::17)
 by MN2PR19MB4063.namprd19.prod.outlook.com (2603:10b6:208:1e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:21:38 +0000
Received: from CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb]) by CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:21:38 +0000
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
Subject: [PATCH 0/6] rv: Expose and preserve nested monitor states
Date: Wed,  4 Nov 2026 17:21:19 +0800
Message-ID:
 <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::15) To CY8PR19MB7009.namprd19.prod.outlook.com
 (2603:10b6:930:5b::17)
X-Microsoft-Original-Message-ID:
 <20261104092125.915254-1-liwei1412@hotmail.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84df36a1-1d90-4393-3a76-08df3a550791
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|25031999004|5062599005|15080799012|24021099003|260925184616899003|19110799012|39105399006|8060799015|4140399003|25010399006|26104999009|440099028|3412199025|18071099003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+MpXdgJgyALzwnEqSDprhUOPgUAz2ssxEMyDbzhn85FosXqKANJBuWhyv21Y?=
 =?us-ascii?Q?Kh6rvnLLpKhk95Ddd6BkHlfobX253w9AXOUsjzIMz1VI7I1iRN1qf/tnaduF?=
 =?us-ascii?Q?HXtxGm3lwG7c5YjVcFV7pZNI4A/6zMzJl61tVmIqwqJN8AqDkBxWXxBWBQkJ?=
 =?us-ascii?Q?x0K3wwtK+FH9UYHn0hBFve2VLJzTUEhuK/rrbMFT/vCTgnFgIYEebaDnkPLE?=
 =?us-ascii?Q?/smHSynFZ9c+FdlVamFhcfiwoFaiD8qqldOc29WxsgpzWQu926DHH+4W6J0N?=
 =?us-ascii?Q?8k5JwANBSuBdEuW4+B0fnaM/e+cJbOGLwDMmik+IYkdr24McZQpiw0D5mBmI?=
 =?us-ascii?Q?pKyvyl2/2JUi98uUzbwPiQ73KHcBLgCUyJFla2b+xiaQNcaZgaeb8eUugdyc?=
 =?us-ascii?Q?6yNtQYqwO42VwvnZJYq1JouP4u4OwwYfO9BDvbG+bnknCjAFYp//TB2/pvf/?=
 =?us-ascii?Q?EeRKrQv8eTAtQ94/8njRE87JO2Sa52oEiim+LlWTrVDUC0fJ9+BlTsYfjAZi?=
 =?us-ascii?Q?8c5HL1u2MFsQ3ByP2O1hLAR3tHD3thlAl8dfcQ6/jpyxixXo4Pi6RkUjxDC1?=
 =?us-ascii?Q?0+Wg6ZAOFk86bfrZAZncDvfL94y8BE7tUU2bil+notOvBTgLQYSDwOvI7pAR?=
 =?us-ascii?Q?lZaDdM4bfJpFiqRkAC488LiTuTZZ0GRLoArqWl7BFYMJZCU5GrasG5WZ7Xys?=
 =?us-ascii?Q?VJ122y+xM4Sf2ZkImNM2SO7Cus8OzdBKRqchDYa4RzNFAH90KsXAlH1Ny6+J?=
 =?us-ascii?Q?5vwAYwcfQ40bCAxStKKQVxF+8X1CMgx2MnjM4/4WegXAjggdRQwfL1FHpLOJ?=
 =?us-ascii?Q?ZDvzL7qrYg5Xxq6Z74Xi1QEXGsJlGs20HZ7XdNpup79lYzD5HCQfJtfgONod?=
 =?us-ascii?Q?rhNQDj7gJxdCwzI6yYb7UNIVMoUhT+FV243ACRWC/fXME0UeWAvsVZRDliPA?=
 =?us-ascii?Q?AfHaZQemiHmLMGplkwY7ZhKbn1vPv92tlBSjE72xhAvEfdV1B9+PvL1DxEre?=
 =?us-ascii?Q?kIgwztxlqesquNj4berP6zkAZg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8CdF1oZhEsZA8BGCcHQJpJ2UJahzSvCaaYB6WMb6jUSDJFeffvwKSZqubP90?=
 =?us-ascii?Q?GiXo6SMl3oOxNHankG/D3piV9Gjly64/M4VbLNCg+J4o8WOjmrOrQYF2cwZz?=
 =?us-ascii?Q?xxJFgBOQhfkqiMdRbDWq+uoRsauuEQDesPkI68mWpFRw7fpofrXNPiAC5Ukf?=
 =?us-ascii?Q?UXXAcb9kLlZYWx4LZu39m9SyskyQpjkH58uJnLf+yk1iZaNb42azyHWjhXRW?=
 =?us-ascii?Q?KAj41m5I0AMIDmle3GzTG+F3EsOlfRdYOg7O+iOsoZddD7uI93TQ5+hvD/wq?=
 =?us-ascii?Q?FmThpc0Ilrd95F4gGTAIlVpKHEOPAhJc/s4qL2ve7NBrPRR228In8Tauvx4w?=
 =?us-ascii?Q?LMY45eKS9qWF4d9vkWY7sMUgYfu+ksvedtUkEzMukNZPdnH3m5nwJLJ5/l4A?=
 =?us-ascii?Q?kqAA2d4wovH4pNDTuh9GT0JgkNQrA1U3gQzi+U7xyLZhhtW77dFyCBwXSky2?=
 =?us-ascii?Q?ofNTqulO9JI0F5De0uHYDAvQHad0xyjITkGDS3dEaYGJO0YO7J0JXLKwVZJM?=
 =?us-ascii?Q?QTLKnS6tBII57Ghgp6PT2Tos1EOjMLiGjriwWsY5SGB33RxnV8Um9Io9Qm+k?=
 =?us-ascii?Q?qhmb6BbZaAAmihSefszm7Y/GPZqoC6x5XYRAegp3NfHid9bCl7N7oVLlqpE2?=
 =?us-ascii?Q?/nbhdBYnHqtF3rXi748OySq0hOUd7QCi9iNsBm0ybP6qWD03erYKAWl+hsvx?=
 =?us-ascii?Q?PIy8ChOpx5OTGmdi4ZV790dEpRCT3at5wLu7aYjxlm+aDLLsQM4LoSXjmbxC?=
 =?us-ascii?Q?v+0A4xyw0l9kVYBydSuvwkWt3cIV/NY2pBe2BRHmOrMwgVKynS4V4qiMccLd?=
 =?us-ascii?Q?QzJ9hLIRc4Q/IG1gicjkcjJeEoHhHYD+5F8r01QoCAod7mDQv7bw/p0dC1zu?=
 =?us-ascii?Q?bHflKBGSZKnoJrRZi8AJ4RkXT1uAVhtH6dotbV8b1t5jCs9rlKpXQftHIr8W?=
 =?us-ascii?Q?NTV0Yu8YUp5HwCIcpy+xedXY2OamOnszNp+7mGn6D7JMcFrla5wEZ0LRkZ4q?=
 =?us-ascii?Q?eKbSbtyagpg3foqV6Tm0RKulq5btTAD38usUUb2NzWXb1XexwaSu7tdogQZn?=
 =?us-ascii?Q?VEiImgFzUegnyiLQdRU884JXB8eJluAu6tcsQXZXtnm47xxK2yPiwq5ToisU?=
 =?us-ascii?Q?0lw5eg/mg18qpHOm2bvDByKqutqKLfltQyxiHs5e8wZltIb3KWkZnAKGDbGf?=
 =?us-ascii?Q?HBBIf6C+HCWdS4441mL7LfbCzgvJfXsDf24cQd0VFC3LxZrpRoI89EKXx/EJ?=
 =?us-ascii?Q?KiZOd3NyVh0wu2KK72o599Ghwv1jdoMc9PJGYFrXzDm817aC/yTk5abg9IB6?=
 =?us-ascii?Q?EW1/GuMYpBtHolYI/lzMCao6qHZHEA+GPSlmmV9bkJw7d7yG5W1ZZ/WooM2e?=
 =?us-ascii?Q?Hmx3QI5I25nXzEA7VN/TLX8xezm9?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 84df36a1-1d90-4393-3a76-08df3a550791
X-MS-Exchange-CrossTenant-AuthSource: CY8PR19MB7009.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:21:38.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4063

From: Wei Li <liwei391@huawei.com>

A container groups nested monitors. The user could not see their
divergences: the reactors file did not show when a nested monitor
uses a different reactor, and the enable file reported only 0 or 1
even when just some nested monitors were on. Switching the reactor
of a container also re-enabled every nested monitor, including the
ones the user left off.

This series makes the states visible and the updates consistent:

- print a "*" next to the selected reactor of a diverged container
- show "X" in the enable file of a partially enabled container
- update the reactor with the monitor quiesced, so every monitor
  keeps its enabled state across the swap


Wei Li (6):
  rv: Mark diverged child reactors with a star
  rv: Update monitors through a quiesce helper
  rv: Show the mixed enable state of containers
  Documentation/rv: Document the enable and reactor states
  tools/rv: Parse the mixed enable state of containers
  rv: Do not send the trailing NUL to userspace

 .../trace/rv/runtime-verification.rst         |   6 +-
 include/linux/rv.h                            |  12 ++-
 kernel/trace/rv/rv.c                          | 101 ++++++++++++++++--
 kernel/trace/rv/rv.h                          |   2 +
 kernel/trace/rv/rv_reactors.c                 |  56 +++++-----
 tools/verification/rv/src/in_kernel.c         |  32 ++++--
 tools/verification/rv/tests/rv_list.t         |   2 +-
 7 files changed, 164 insertions(+), 47 deletions(-)

-- 
2.55.0

