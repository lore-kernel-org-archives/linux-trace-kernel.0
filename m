Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED625C822;
	Wed, 16 Jul 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676225; cv=fail; b=E/lTZWFT31wlvXtDbmtQ7r00eHtJEQuGFnlzAdL9+RilDhLU/6l9pftxQ4l63XDVyFklRiha40lQjGNSXzBPedKf52Kp85G34mheBQ5rd8nXRE7D2cwZZwwm89Rm7lv6QGZg9nzpQOgpdvZZx8UhuKNtBF5/y8agbWSZhEhSUCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676225; c=relaxed/simple;
	bh=lutfXrVopPOFUg4o8ZY4oJNviw0l4ja/Ra4I9hiNH2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hQLiedJdQx6erw99SUQ139Dy6TGGvQvQP2mPEIxEooHC+fWyG3sdNAYNKxeN7WL9aiW2fiI+Vm0NsWA0jB4ILLwQxFzQW3K4yN2e5vJxLXQzoDW4n9tnK/uDNVDHRxc6rvQIRMl3XuWRfrmHEXe3PinKTg8iU25zd4QkjTRCui4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o7HnbS+G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Upco4u6b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o7HnbS+G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Upco4u6b"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G7fnjT018585;
	Wed, 16 Jul 2025 14:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XXqMUPzdIOymwpxzzd
	17qZ3vF6AUPPraT6gmCPXbss8=; b=o7HnbS+G916ZgA5pSVbneVmpwf9scHKCa+
	WYHW0Mo426790SUkMuKTTOFujqcWOeE4aClRQWyVoL24Eqy+/n4rJ8sfnyKwSJ+K
	DfEaQCCGRTb39PKLn6gq1TJIsVi6RZ9nhjqwLTryfWoL8C8pEsWOaczjpON++N4M
	gMmHeTZfkEhv8pQaJ62xHYy+H5KiILSC+N2u6hjmzU/XFfR+1zupHixc/TwJp+jF
	vVWvgbgWVLO6Ma1Od6i2YXK1G2hKCK938vZqjQPO1hcuomp9a7hdnZVId60TIv1F
	mTfebkXL8o1dptVuPP8eB1ZfSfMXwBwHQq99ZvS9CHofhhYX4WUw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqstud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 14:29:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GDMZBa039623;
	Wed, 16 Jul 2025 14:29:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bejy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 14:29:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXTIEEPDbkKJi0ewcsFMzPOEt/UZdzU9t6Y+MUJVlpwiAC/uGISp0qdpLshaZKK4bLXWlwjMJJdB21/WB0sVAHxEVDKkJe1uFvGyq2wa4oYlqZKbVOGaK4DhyFNjKTwkKvrBumoewaV+4E6AIUDcslX7iyhdKw0EBzGpkp7uHnP3puCN4xxp2J596suBXJttoWtHqp0GTtPbc13NYWDyWWoHyOVF3cwfV/IXRpBoD1cKlp4MUq98uWct25voAac6df87SByvLGT21VRKjmItKY9sXHiBUuygXfW+bvVsqaWFnnF+uCoo+xSHp203aCD/WliCfQxhoXVCTCHtmUyaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXqMUPzdIOymwpxzzd17qZ3vF6AUPPraT6gmCPXbss8=;
 b=MWc3P8Gvko3CO/il2Dlz93KU3I9ACPz7hEysuyfxZkzwpw18AzyO2ORCOadl0Od+iHD1Ih7NiOt6RT81ydb4OBJevoWpWsba9QXB74zb2IrfKekNPxXFIsEQpB5mCBBZOR5NnG4IaknJgo5DuMMuBFQrTsSHAlDWSh+QRHqCykANOkbWfjYqgBFifoF9H9oVWavsldUd0RiRTJCtIGaI1EMA/UH7gDwdn6HYPECXc/LA2f88PV1swc1WgFsYbp2RQtPYP+LgyBDm27nmxk1OoR+vzNmIvZ2ZCgUhmKVOkcD0U75Sr6+WEovfpQn5diYgHp9XdMPOYmdqNldfFW/T/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXqMUPzdIOymwpxzzd17qZ3vF6AUPPraT6gmCPXbss8=;
 b=Upco4u6bsMD8pBOt3WGSXpFnNuxrFQxeK3jtZUhfHhTD5tRIq/rH/1G12vIeskSGI1qBNbmdA8DtnyqEevaWC7yUSDhAiZ6L0Y5vYNFzoXzDTBVPIvUVXDnQtMgUU3bVSs/+T/kk0ZXbp/wJFspWmcQOeMk9ESHto7Wl5g1LwiU=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB7118.namprd10.prod.outlook.com (2603:10b6:610:12b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Wed, 16 Jul
 2025 14:29:34 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Wed, 16 Jul 2025
 14:29:34 +0000
Date: Wed, 16 Jul 2025 10:29:28 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        lorenzo.stoakes@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
        corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
        baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
        tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com,
        jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v9 01/14] khugepaged: rename hpage_collapse_* to
 collapse_*
Message-ID: <qgcvsfhoq3pnvxhdn73dopbtvi75oghbaydg27atqfp556u6sa@ixwdwi73lgkl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, 
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com, 
	mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-2-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714003207.113275-2-npache@redhat.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::25) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9b8498-098c-448b-df45-08ddc4752fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T14hSL54X0+A9P2ydQvFul+8hbDCenFftz8s3rdfTGkvPyWSvV82/TAXqIBf?=
 =?us-ascii?Q?s1AUQOANZf0P7Z0mGSPXdhGRAsKvuTK3vFMeukZvKqnfBorI+aVcdroSy3Xm?=
 =?us-ascii?Q?o3XveN1zTlmQ9/n/8iSBy6wc3tTyYAooHBBVmrJ03OdkzHRPxjPkQUy6z3Ct?=
 =?us-ascii?Q?Ux5lbZJJr3Sk5htKiEHrcKatKVLHpdikMLdtKxIPacv5H7gZnYqPGJ6s5uZC?=
 =?us-ascii?Q?7rByB02/dz+s8cx0nXN8juLbb3SFVCMKiHGUqQ+euLs7CQxHnoyBSTN3trxI?=
 =?us-ascii?Q?M4tc8uXqfh75Wg7hrRFAWDkkqj3FHyqctiuXbGXKoKaF2c5rJVy/7/K2v7Aq?=
 =?us-ascii?Q?90udanXRgqHgviy+4nbcJYkglA5wvSWd3TMShdw55caggA/8+BdggamZwzBy?=
 =?us-ascii?Q?dPUg2a1ErzhtX3Tg/3+6IvioHFSGAQ+ScUDhsOLnAgImFw3d3JKWcyEJ3k4I?=
 =?us-ascii?Q?rhaYMY4pQ0fQ378/WDwOZ5pMzIYjrmyN6TwzZZ5SrdblihtKhihdvr3Oygg4?=
 =?us-ascii?Q?HhMl71jvMsl44/cv0zdEm5wf7n9V5MJjbvGke0LlmYKKieGN4emeE9/x0BRZ?=
 =?us-ascii?Q?dWN91w58S6ZCpYOKKm3Zgn1qzhQaBEi5W2z1kaPCHo809bwjhPBu/GnaYJKp?=
 =?us-ascii?Q?JzM3CAz3FtPdIksDQrh01kbszlc2qe6CpjfcM20qUL19X4sn2kaWUTaCWpaR?=
 =?us-ascii?Q?M0tgbJ3g1B51ugSJGRJK5Ou+O6G4tIDLb0O2M1ybMlRHoZ3fcUB0edj5mBG4?=
 =?us-ascii?Q?mkcCVs65sU14/X+R5HBwNGUo7HaLm3jCSWDpUBtJx916dWs0vbm7n6EPJM2x?=
 =?us-ascii?Q?b/Lt6VO8BwrreZgVnl7nkZCjfVIctezwCno5gKXz8Zlhe7NLhNp7tHDrawZ4?=
 =?us-ascii?Q?JwH1xSuFASH/QqzgmyBqIs+PDseullpvo6nZJgK/j3CVuy+C2LABbNJsnP1k?=
 =?us-ascii?Q?BxP1Ivj7TbGZ87ZYYo7uTUV/Lx4+n79tJ51XXiMGoIlA/Gm6oH86JseOKfum?=
 =?us-ascii?Q?6ejzJ8Zu/zEcK5jc62lzVDAQwKKhd+Yt0nuMvQwPnERsgR68AmsiZsn4ISNb?=
 =?us-ascii?Q?qAuRqVhbxJL3Slb2SGi7bC5ma8ZloAqpDIz32iQZrNa6rX1qc3ZZjcOZdP1D?=
 =?us-ascii?Q?jyKqADH/TLMqHuzvbmszSB+BaxbG8P6i1QnDLCoHAECBJfw0ZyIHp0T1Qveb?=
 =?us-ascii?Q?QxcWMEgAH4f2A1gPGaMplkFRA8/Km536srwbQ9sbVTqfbTInEnB35iVk+vzp?=
 =?us-ascii?Q?ozgL4AgqL4Q2Lr87956SgFBbLSUqCJXIyQ8gc83q68eh/dKQn5z+bi182r6Y?=
 =?us-ascii?Q?7dRODEixoFxZubOma+5pfJf7P0VlvYcXqUi4RSuT1h8K5gckarD5bXtPSU6Z?=
 =?us-ascii?Q?ulO+OdYvjaJmF3hhVA3rui29DS1JpBu7GPrJZsW4Tfw4VrKtC+TgFTqD2LyY?=
 =?us-ascii?Q?aYkeDFslsms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Ioiue3ydC00YlkXWif2k1kTn3t5cZjaYcbAULI7WUiQk8X8ldIEMjlljYbE?=
 =?us-ascii?Q?nHLdw6C3X5TDaKNNshqNtTPqb0XfSgTuphb3UMb4Ob48EUDvnkc+x9uEnUkZ?=
 =?us-ascii?Q?7y+8siR9jiRr2/IlgYC/alyzVmM4dp7fzMmQPitzYdj/i5r867cdd6+f/ss8?=
 =?us-ascii?Q?9dFoyt2eoxEU5QE2eLyxIxeXdM+RUfYRatCyrmiLmdjtjvL0LhvGqhzr54XE?=
 =?us-ascii?Q?YGXdAuQb1anLXEPzlXrlnOlLfvIrPq4Cmrdn2OptvQ0mZQc2jrTiBjXnQZEl?=
 =?us-ascii?Q?QgNBX3/U8Fzs0+zwzNyaBYrKnTJ2x3kuXX0s/zV4Tz9HMOcy2zvoTIC+BFHP?=
 =?us-ascii?Q?puT57/QIV1NgUNegIWwdx87oMTC5q90PnvFKqei6Br6RAen7DGSP/89rhpha?=
 =?us-ascii?Q?HbPkXjiWc+Uh7Udl8rxJ2EHrqlcnKAEtPHc0SuQPN+tnAKdYBsJyoC06Nl65?=
 =?us-ascii?Q?eietnr0whqz/4tmptqH/2vvDql3bzEXPIb9ONVKNi3Ox6zZrTBwoItOqcTNH?=
 =?us-ascii?Q?V+rVmFN2w0n/dkIklLiqjjS/t5FEopb43604wNXQiF76TapG3/a0YUEyASh6?=
 =?us-ascii?Q?MFw+nNTP/mDC6lc5rs1f9NNRiPtL0aRiHDYRf2bZcEFAFI4a1Qm6/E9A/+Da?=
 =?us-ascii?Q?yZWULpAngdZjJLclBUOcTMjrA1B/6MH+3RXL24Jx6Wte9c6r7C5S3zFG7iaU?=
 =?us-ascii?Q?31Xf3vqdcXrXwNPK7RhR10mMSZKFKAaagXVpQ6D3OsaIU4dod/OE2ls0muNb?=
 =?us-ascii?Q?k1db5RfUEW/Uxp8BGqsO/HoTDbXrrum3lOYZTBYssVmZSbKCvuAgTYNc2VPk?=
 =?us-ascii?Q?u+zZaoxqurgYsV4icrm6rf70jtYfM0OJbEU8U2LWY3iX4jFfxgIr0sZ7va0S?=
 =?us-ascii?Q?38s/4wBmdzc6kzkyqlbSQnLmVeAyAh0tCqvUM7sM2z2E7gR0uvBzCJgOYq72?=
 =?us-ascii?Q?hl4AL9mb5wEr99xzcwUUxnv20zS3mmp3U3jLW57CbJ9SaOpsEezMOQmxEZJo?=
 =?us-ascii?Q?LcVUsofLDoJwrCtC9s/ayKMJ+w6XHwdlRKBmx2C68IbveUytXwaiLXX6KOJO?=
 =?us-ascii?Q?D2w77Cv5F9O4LJwSQsksE684039R1qGfPOsgmvGr61MrzYaEBpbCaWYt11TJ?=
 =?us-ascii?Q?MHN7NQwX85y9cn3ZhpU/rPoUgR3T297b1DRA0XhivoGt5lviPaSK/Dqk+/v4?=
 =?us-ascii?Q?pCdc6rFgeWDlG0H3/FJBSbEq+7Sw8wb8cvtsJenS/EsEQ1ZZhX57TglDL2W+?=
 =?us-ascii?Q?aCQATuj4XXRZ1h6PAfEjggPJF5teTDdIThyJFiwYa1P6nlx+4PmgUgg0oKnW?=
 =?us-ascii?Q?N2PIR7Na8/lbUCTj3xfI+5VlT+Escarmk/p1V2Ns4Aqa328kv73cTPszGCqL?=
 =?us-ascii?Q?I5BUBA9syxqP3tnayWs+QbV3RlrnasQt03xf7T3gSvdpJtUvoJsZ+hE5DUnW?=
 =?us-ascii?Q?3R5KcLDgPF0SuzutTlxgCNTu/E8XkqwkIuU2FPjjYT2E4ay81BlQJt+3+B7X?=
 =?us-ascii?Q?hhTVRgrzWH1mxqZjYljyIMItUThsEpTDd0c/QSWudYbzFXCNxxlEOIcjTyra?=
 =?us-ascii?Q?13wksRfF2ClH/FsNtGPBE0sB5Y6LE6fKIMsPCiLH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h2QXgyDShlPEtRG5E41jBxwHCG69xFDrPuZC7GX6wySmdMqaNxrvp6rqUscUIglHOxElidF4MLMHLayc7r38sz3FAfwTqiOHgY50LnZLqxvq109QHznkkp5mpTlDcx8+m6Is3YNRZbCKK268EiG8kCS8+DZd/0jhOaEjpRUiDqWnN8NwViV2EYzpm7+bThsjdbQfUhqarBP/jegPi42P1EG+kEyE3dzkagf1FHkJ9b62bOrCmeI8HmEkWbDar1bRfKo9zNMVQl+m4WSVyYsS2jPJKCMbWGWtTi5l/GvNrv3qhi/Fwpq82PcPaz556HNkooR9on3R/f9BYVcV1nIvvqJE4fwNXxzqREtL8dAm2ajJi9cD1BMW6y7rp7yX95KOH/H9/5W9tqXBRLt8UEpKsnXpJAxvpsjqNmpMpv5I7r/wPXEFiyx979RK7ebVHcs0CTx2seaxq+m2gqo9ZSRVJjetF4V2Rzd0/7o7jZM/sYBTXWU1I0e73h+PVl5DQ5RQNsKyLrkXpXeUNXYz1p3PP1FpD5ZAF5kkrfEF4G6Id15b2ri3HxA5oVhRVUbWMlZsiji2//xZ6oFeo1RQgt7TDgT/D4rKSiNT3JTRZOdjk0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9b8498-098c-448b-df45-08ddc4752fab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:29:34.7959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGytRGqHhf+5sgR42Z3YWOEHrMVREnNohHzK10ztfRaTcwHkMMHu6Lm/u30C7FvJ3MNgKt/2D0gYSgEUI/Xh2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160130
X-Proofpoint-GUID: L_MC_F5pY5A4qykZaZdUsMromkcte7Hv
X-Proofpoint-ORIG-GUID: L_MC_F5pY5A4qykZaZdUsMromkcte7Hv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzMCBTYWx0ZWRfXy+xdgiH2MebU hpfxpkJWtMAdIldV5wSbk1W/2FIIBNluxVdSBFEIzTwppQ16SFdlQkfyLszGfpJgpygBAreplJ7 AFdQUK1GQP+vJdsK6WiSjlVj95gzueRAcHdWlE0Qfp+iqAuEsUe0mjLdFrMPVac1AcoMMqOBtzE
 F+E+KEnk7/DJ7HVIMqUWDnUL57ZQIrk13owF5xfn+mLXxsxJH0QGDspruA33BUK0UtzWDQPyVo3 VoYsWECR2qAcVugLn4Y+BcFUW3Ka1Tth5pO+uQhmyPlhnN+98XOgasLDRnP+yMI74pJLRnDnO8T Jr0r25xiLbimR0ylJYB9UDWi5TMN+Bblijkz4aCyguXBGpGYGLhdQO/kBLV7/TU/7BB9If7mHWA
 Y2WrqD8YstBy2ofQUKlGDfjiW6s57XJ0/7R/mo33Fnw4j8fNyWMbCSRePIpzP6dUbMmdOUcU
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=6877b753 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=SRrdq9N9AAAA:8 a=yPCof4ZbAAAA:8 a=rAJa0-aF1meQ8cdFi0YA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600

* Nico Pache <npache@redhat.com> [250713 20:33]:
> The hpage_collapse functions describe functions used by madvise_collapse
> and khugepaged. remove the unnecessary hpage prefix to shorten the
> function name.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>


This is funny.  I suggested this sort of thing in v7 but you said that
David H. said what to do, but then in v8 there was a discussion where
David said differently..

Yes, I much prefer dropping the prefix that is already implied by the
file for static inline functions than anything else from the names.

Thanks, this looks nicer.


> ---
>  mm/khugepaged.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a55fb1dcd224..eb0babb51868 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -402,14 +402,14 @@ void __init khugepaged_destroy(void)
>  	kmem_cache_destroy(mm_slot_cache);
>  }
>  
> -static inline int hpage_collapse_test_exit(struct mm_struct *mm)
> +static inline int collapse_test_exit(struct mm_struct *mm)
>  {
>  	return atomic_read(&mm->mm_users) == 0;
>  }

...

> -static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> +static int collapse_scan_pmd(struct mm_struct *mm,
>  				   struct vm_area_struct *vma,
>  				   unsigned long address, bool *mmap_locked,
>  				   struct collapse_control *cc)

One thing I noticed here.

Usually we try to do two tab indents on arguments because it allows for
less lines and less churn on argument list edits.

That is, if you have two tabs then it does not line up with the code
below and allows more arguments on the same line.

It also means that if the name changes, then you don't have to change
the white space of the argument list.

On that note, the spacing is now off where the names changed, but this
isn't a huge deal and I suspect it changes later anyways?  Anyways, this
is more of a nit than anything.. The example above looks like it didn't
line up to begin with.

...

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
