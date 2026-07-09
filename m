Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022140.outbound.protection.outlook.com [52.101.126.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB93B353EF7;
	Thu,  9 Jul 2026 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606953; cv=fail; b=XDUMtinKAieTq8qdnBS6CbrEu4Te5yNW+vITPi/kyatNzI8T8bvZbii2rSqLBJa4C/tazkN7Xg0xS5HY1j6QkR/KoJ0NEmWKXZM71zzh/9kDz6CyCNf5ZBr3LZTE9z939PWs0NqcN5iGCUG6HtzBrkGcGPq1cE4hkEEGDX+ZJZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606953; c=relaxed/simple;
	bh=BgEk4vFcwegNImrMPl3UzRX0D69J+6KZJZmr1qt59ns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BZffJSk+Qz+FQ9aVm2ptxlvT/Z7wODtOku8zN4zuce6HvcyhJNCG7LCaUiVSFKjMIQhFDM0xLJ395Gsn5CUXnikBkK9oyfe5aEN0Hp4l2RFXFF42e2+LfMMIGwyPXtIWsTfVOVMs2unPTx0tqwPOy7vBVOYRR6iZKv7Hc3PGjL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=qntKlg89; arc=fail smtp.client-ip=52.101.126.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="qntKlg89"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q00UVjYX4nw1QOKtlfF+UqOVqSA/Azt+ZZpEKPBJf/yRIS1Ff00gS4G89TAXuc16agsSdrrNIs/J4bXSUqioNxv3khJPzTCfzNibJlV4/hiCVUuynQChP4+ymQ18WfCUmssc/9j/cZaSNxrpRXfnyAziFr/t0cTcPPgWlizTKoSEf/i9QhRL+H+x5pa8Xz6CirpBXMH/PuAo5UdokFdsNcqSrrq8HYnz/P/+pg9igu7pHkKieCyVJ0Rie4aQMjuCNtIreTJbDrRHQiuTzKilzJWyH28jwuZRw1ppMPxof+iEmqC9W7qayt5hU0huhN0vEYi1Potf2iIv37EG0mI0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgEk4vFcwegNImrMPl3UzRX0D69J+6KZJZmr1qt59ns=;
 b=ephQR4Dczop8RyGY8Yx8AEoWKVh3E0Zk0Evdm+JSvwfdD/7VIFZMmMlCwkDyRn7SZFKdxiXOuHflXwRL/Ww7CUi8TBbossvXep19aPWhM8PlrPy5QcqX4bWZemIw1kwoUrn8LEj5qYGWWL7KBWLs8q8WzYkiAQTERLhriGKGjqUgEN4pia9Yy7O+1iQv3LHhsQ4D0sc5qTYVPmZJALDIJWL5YMYJpJTOo7gL8LCuvLgMDPz0zK2+0ym1c9oThV9uPst+n7+lL1fN9I5IbbyDidYlN84uCoXqu9ex2YyYfu7kNCVfKeXg4gYbGVk6PXjQoSNPCOv3ashYbpipSXm9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgEk4vFcwegNImrMPl3UzRX0D69J+6KZJZmr1qt59ns=;
 b=qntKlg892jIidJfu7rO/9q0Ag8U+Q+773oOu2flndAn+P48yPkBM6wvl5TY0OYrGPot/RXogeTxJcgmdBOn2OtBPyVNn4llqPZR/kBsh+9bci3zSOlOiI+r3dLo0PlSvLEZiSi5j99A1M7YbkKiHeYFzEAF6/ZLmEvFMkwm3uLI=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by JH0PR04MB7844.apcprd04.prod.outlook.com (2603:1096:990:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 14:22:27 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 14:22:27 +0000
From: Pu Hu <hupu@transsion.com>
To: "mhiramat@kernel.org" <mhiramat@kernel.org>
CC: "ada.coupriediaz@arm.com" <ada.coupriediaz@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Hongyan Xia <hongyan.xia@transsion.com>, Pu Hu
	<hupu@transsion.com>, Jiazi Li <jiazi.li@transsion.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
	<naveen@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>
Subject: [RFC v2 3/3] arm64: kprobes: Save and restore saved_irqflag in
 prev_kprobe
Thread-Topic: [RFC v2 3/3] arm64: kprobes: Save and restore saved_irqflag in
 prev_kprobe
Thread-Index: AQHdD65eHJ4htT/1VkGfVWGN6UJ7Zw==
Date: Thu, 9 Jul 2026 14:22:26 +0000
Message-ID: <20260709142215.226872-4-hupu@transsion.com>
References: <20260709142215.226872-1-hupu@transsion.com>
In-Reply-To: <20260709142215.226872-1-hupu@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5648:EE_|JH0PR04MB7844:EE_
x-ms-office365-filtering-correlation-id: 002fd2a7-1257-4bce-abc5-08deddc580a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|22082099003|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 DohvyJJN3e4RRlYOQsU0gvZwNhPKGiyRWV/wNz46+jTO+C2zyx21MOaw2KU4UWsgi6Vxm3FXflf2PcQWG9jpmctJIcscIob1HqS/hR4bRVEyAKVFJMW1wUC7YnmZp96kNhdjWyg3Iypw+wNEMA580WDL1xvTieAYdYTem9W1miA0eVh2N2WGfMJZVYTT+WzXuuSTDlWiUbqvLRxl9m392xf6ljN9A7Jnpxf92M7shjJwsDlPPvr+Frx1SRBzzeWmdeOlnYBj0DG++qr5HW7Awd2hXePvF705cmCtYaipk2ItDKeCUar83uYQ2Pma+qxtRtS3k80o4d+uRrtt9LEJOrbQRlLAtsgX6H51pWdaVh5rNjfbvTXoIUUoMJjHoDxtDOPIQbzE8zgAW00TOfaeY90JKKW4Wy520dMAXjlFYid1tbJY+Gz3WJjrjzxFuc8kcqBFAQN2ye6XM08QqwUWQwjQdplQgku48CzQhVeL0IQm1YoenHST7dsRjiyba4Hn9XvPMBzMWPjWwGlhOd4TRoF5dt0TL/CIdDR5PubynWJjbtQYCdHY2IxSo3OF+j6qMnYKZahY2uTJ+8d5J2lkeTFXUzCIcnKEWl3yuNJCwz7azkPtU++9KRXFfEQr8p6hsn3fE705y2okG7BObinrOdjtw11yKCps3DU/tYaGgC9ogZER64yTuUOnXemaGlD/4yzMakllbq/DvzwkxLYBgLj9YL+2FUln2c11HsNlwYk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(22082099003)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTlUb0lZL3lCOHAwODlNcWpHWU5UMndpQmxBUklqSWZEZnJHRzhha1JLaVNj?=
 =?utf-8?B?QTF2b1lLbVd2SFpsRm9PdHJ2Z2ZJQ0F6R2F1Q3VFZldlNjhIZUdaQW1NTFlD?=
 =?utf-8?B?WDdROTA2NVR4QkZFYkxXWmpKZlp2eEpOM2pwZERTL1RQUzFOZ1o0USs5bmhD?=
 =?utf-8?B?TDg4azFiUkRvVFY1Y1VYWDU3K1VWcEtROGJ6cWtNaytuc2JXeC80RURjVFFl?=
 =?utf-8?B?OWY5QU9La3BxMVk2LytNLy9YdHEwR3phNlJpbnhlSzVBVDVtTVZSUE1FYVpG?=
 =?utf-8?B?aENwZStqbVFaQnhJSERNbmc0MUM1SGNRWkJ4TXFvMDdySG8rbVo1T3B4NmRa?=
 =?utf-8?B?R0JkazFWOUF3MC9XZVdFN2p5YTQvYXdFd0grVnVFM01rZWdncEkwS3F5STBO?=
 =?utf-8?B?QlBVV3V6SHRmc0lwMUdtN3lETHBiNmdpeGxHclpvYk50a0FZVGp3OXc5RDBr?=
 =?utf-8?B?bzk0UmkvS0VNNGZVemhTK0Q4dVBJTDFFbE1CWjZkQTNkem1iZjlRTlF6WmM3?=
 =?utf-8?B?ZTdhbXVUTDJYM1B0RVhxTDhJMjVwMXBWSVp1WEFuOGMxTlNWamI3OEljMnBR?=
 =?utf-8?B?RmE1eTQ2cHRBUm42Z1hyQnRmakJWbjMrNFZZMzRscndKQ0NXSTBPU3ZlbjVR?=
 =?utf-8?B?emVqWU1XQTcySThuQS83aVVZVEVQbytwVDNrKzNBcFVZdUhQcmdWWWhQdlVa?=
 =?utf-8?B?MFJYNWdZa2R0a2JPYWp2MnQ0TVJKbFZPMTJlUGxsQlk0VXp3UVc4SWkzZU1o?=
 =?utf-8?B?aEJzL21XS2tmQ05WN3VEV1czcGJMOTduTDNNalhLc29oQlJJRkJNdWorb3M2?=
 =?utf-8?B?ZG5YUTR0RlRGdkJIZnlOa2kza0lka0p0elhNQ2tSVklFdTdlTHJkeDNGck5n?=
 =?utf-8?B?NmRTUSt1aGQ2SHVpbXc3SFBuMEV6OUpQQUFmT3FSOHB0YjZ0OThoM2FqSEdn?=
 =?utf-8?B?OWlSYytqT3hGL1A2V2czVFFSVnB1eEREa1l1M3E2N2ZmckdYMi9oRVhwRzk3?=
 =?utf-8?B?SFBKVzBDY3ltb3hEVGpBYVdTQWNCRGxOSkJ5WmNzQmxaRWZQUWVsYTAvT2tq?=
 =?utf-8?B?aEhSb1cwWjB4eW5rS0ltVWN5Wm1CRlI2MFpjU0FQNjdqRXJOaG1mVTRnZHcz?=
 =?utf-8?B?b2JPY2RPT2IyYWhJMFl0V25jVC8zNWFtc0R2NGJxNHRmRnhWZmd4djlUU3dG?=
 =?utf-8?B?Q21tdzE1ODZRYStwMG94WUJ1Sytsc3pxbmVWbGJiblVDQm5TVXEreTRjUnE3?=
 =?utf-8?B?MFMzN0NySDZ2N0Y0Vk1ITlgrc3Faci8rdGRuaXZIVnMwVjUvQ01ieHZvbHl5?=
 =?utf-8?B?cEZrZTJ1YlFaL3JiVHlYMTRESnYyMkVDNEV3VzBJTzZPcm9GeWhpUXVxUDZm?=
 =?utf-8?B?ME9zampYb2VYbUJQeVhXN3hjWkZHVW5SZStMUzFUQWVHWUpzZWVnVEsvdVNi?=
 =?utf-8?B?L0E3V1JHOG1OMGUrTkt2MHpqMTlhbXJBTnJsd2ppUGJZK2crNHl5N0QxRWly?=
 =?utf-8?B?cGdGMjNxZWNZNTdxeHB0NjJObUJ5aXJEYzVqSTM0QUI5cW45U2h5OWtDMzdP?=
 =?utf-8?B?V1NyMjJKOUNCZVJya0pJQWNRRVlqOElzdWpQMGpQMXl0WUxXeE4wZUtUL2xO?=
 =?utf-8?B?RllSMld6Z3Q4bEpHNHpRR0lrTjFydXlWYnpKN1RQbmxpL25MVWJwSUlGbzlX?=
 =?utf-8?B?WE5nUTRYQUtjQzZlaG5QWUsxNER2TTFMRDFqZE1qYmZTTWNqcEp5MWtsRjJW?=
 =?utf-8?B?bnhGRVBvcEhTM2JoRG03NTVCVWQ1UmVaZVo5Z3AxWmFUYUovOW00cVZrdXRD?=
 =?utf-8?B?S2hlRGtEYy9RNm96dmJ5cjRjeWxMNHV0QmRuWENYSlloZlZxdnZaeFdrNitH?=
 =?utf-8?B?aTViN1BUVUZBc1Z1UGxubmcyMmgydDVHWnFXdmphSnZCV1pyQ2ZEb3JVb280?=
 =?utf-8?B?UWdKVlc5aUNIUTQ4YVNmaHZFTWZvVEtxSm56a2RMa1oraU5wMXRFTk92Vk9O?=
 =?utf-8?B?cmdyRk1GYWtnTU9Qc21xdmtyWUYwRWR3bFk1dTdKN29STHZJdUFEMDkrYS9Z?=
 =?utf-8?B?NEY2YTh1K2xnMmVIRDBNTDNqMkpGVFA1VjBEYU9WOGhDUHpFMVVKTGR1K3RY?=
 =?utf-8?B?TmROU2xlNWx2QTJpNk5MdXJtQUpjakdMV3d2Q0pjeHlGQ0ZCcXNOSWFkbTBa?=
 =?utf-8?B?ajZDajJNMnZwbHRLZ2s0Tlc5bU5ZM3FEb2dvOE5EQkdLZ0k5MzZoYS81NHVv?=
 =?utf-8?B?Zlp5WGdKUDBOT2V5K0hicTJaZDBOU0hTTVJUS08wU3k4NWljVTlsL0thS09H?=
 =?utf-8?Q?bZEN40J7C26+Vmfbnm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB5648.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002fd2a7-1257-4bce-abc5-08deddc580a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 14:22:26.9776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZ4CFDibR1gv+V94ECGPtHAzBKGWzNMbLMDhQ0JfsCYLwpFsSgl2WRTH5KnLOhPk4zJZTCt6U5DvkA1N/MN+7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7844

RnJvbTogUHUgSHUgPGh1cHVAdHJhbnNzaW9uLmNvbT4KCldoZW4gYSBrcHJvYmUgaXMgcmVlbnRl
cmVkIGZyb20gS1BST0JFX0hJVF9TUyBzdGF0ZSAoYWxsb3dlZCBieSB0aGUKcHJldmlvdXMgcGF0
Y2gpLCBzZXR1cF9zaW5nbGVzdGVwKCkgZm9yIHRoZSBuZXN0ZWQga3Byb2JlIGNhbGxzCmtwcm9i
ZXNfc2F2ZV9sb2NhbF9pcnFmbGFnKCksIG92ZXJ3cml0aW5nIGtjYi0+c2F2ZWRfaXJxZmxhZyB3
aXRoIHRoZQpjdXJyZW50bHkgbWFza2VkIERBSUYgdmFsdWUuIFRoZSBvdXRlciBrcHJvYmUncyBv
cmlnaW5hbCBEQUlGIHN0YXRlIGlzCmxvc3QuCgpXaGVuIHRoZSBuZXN0ZWQga3Byb2JlIGNvbXBs
ZXRlcywgcmVzdG9yZV9wcmV2aW91c19rcHJvYmUoKSBicmluZ3MgYmFjawp0aGUgb3V0ZXIga3By
b2JlJ3Mga3AgYW5kIHN0YXR1cywgYnV0IHNhdmVkX2lycWZsYWcgc3RpbGwgY29udGFpbnMgdGhl
Cm5lc3RlZCBrcHJvYmUncyB2YWx1ZS4gV2hlbiB0aGUgb3V0ZXIga3Byb2JlJ3Mgc2luZ2xlLXN0
ZXAgZXZlbnR1YWxseQpmaW5pc2hlcywga3Byb2Jlc19yZXN0b3JlX2xvY2FsX2lycWZsYWcoKSBh
cHBsaWVzIHRoZSB3cm9uZyBEQUlGIG1hc2ssCmxlYXZpbmcgaW50ZXJydXB0cyBwZXJtYW5lbnRs
eSBkaXNhYmxlZC4KCkZpeCB0aGlzIGJ5IGV4dGVuZGluZyBzdHJ1Y3QgcHJldl9rcHJvYmUgd2l0
aCBhIHNhdmVkX2lycWZsYWcgZmllbGQsIGFuZApzYXZpbmcvcmVzdG9yaW5nIGl0IGFsb25nc2lk
ZSBrcCBhbmQgc3RhdHVzLiBUaGlzIGVuc3VyZXMgdGhlIG91dGVyCmtwcm9iZSdzIG9yaWdpbmFs
IGludGVycnVwdCBzdGF0ZSBpcyBwcmVzZXJ2ZWQgYWNyb3NzIHJlZW50cnkuCgpTaWduZWQtb2Zm
LWJ5OiBQdSBIdSA8aHVwdUB0cmFuc3Npb24uY29tPgpTaWduZWQtb2ZmLWJ5OiBIb25neWFuIFhp
YSA8aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4KLS0tCiBhcmNoL2FybTY0L2luY2x1ZGUvYXNt
L2twcm9iZXMuaCAgIHwgIDYgKysrKysrCiBhcmNoL2FybTY0L2tlcm5lbC9wcm9iZXMva3Byb2Jl
cy5jIHwgMTUgKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2twcm9iZXMuaCBiL2FyY2gv
YXJtNjQvaW5jbHVkZS9hc20va3Byb2Jlcy5oCmluZGV4IGYyNzgyNTYwNjQ3Yi4uMzVjZTJjOTQw
NDBlIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2twcm9iZXMuaAorKysgYi9h
cmNoL2FybTY0L2luY2x1ZGUvYXNtL2twcm9iZXMuaApAQCAtMjYsNiArMjYsMTIgQEAKIHN0cnVj
dCBwcmV2X2twcm9iZSB7CiAJc3RydWN0IGtwcm9iZSAqa3A7CiAJdW5zaWduZWQgaW50IHN0YXR1
czsKKworCS8qCisJICogVGhlIG9yaWdpbmFsIERBSUYgc3RhdGUgb2YgdGhlIG91dGVyIGtwcm9i
ZSwgc2F2ZWQgaGVyZSBiZWZvcmUKKwkgKiBhIG5lc3RlZCBrcHJvYmUgb3ZlcndyaXRlcyBrY2It
PnNhdmVkX2lycWZsYWcgZHVyaW5nIHJlZW50cnkuCisJICovCisJdW5zaWduZWQgbG9uZyBzYXZl
ZF9pcnFmbGFnOwogfTsKIAogLyogcGVyLWNwdSBrcHJvYmUgY29udHJvbCBibG9jayAqLwpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYyBiL2FyY2gvYXJtNjQv
a2VybmVsL3Byb2Jlcy9rcHJvYmVzLmMKaW5kZXggMmNhNTkxNmVjYTJmLi40ZTBlZmFkNWNhZjIg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQva2VybmVsL3Byb2Jlcy9rcHJvYmVzLmMKKysrIGIvYXJj
aC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYwpAQCAtMTc0LDEyICsxNzQsMjcgQEAgc3Rh
dGljIHZvaWQgX19rcHJvYmVzIHNhdmVfcHJldmlvdXNfa3Byb2JlKHN0cnVjdCBrcHJvYmVfY3Rs
YmxrICprY2IpCiB7CiAJa2NiLT5wcmV2X2twcm9iZS5rcCA9IGtwcm9iZV9ydW5uaW5nKCk7CiAJ
a2NiLT5wcmV2X2twcm9iZS5zdGF0dXMgPSBrY2ItPmtwcm9iZV9zdGF0dXM7CisKKwkvKgorCSAq
IFNhdmUgdGhlIG91dGVyIGtwcm9iZSdzIG9yaWdpbmFsIERBSUYgZmxhZ3MgYmVmb3JlIHRoZSBu
ZXN0ZWQKKwkgKiBrcHJvYmUgY2FsbHMga3Byb2Jlc19zYXZlX2xvY2FsX2lycWZsYWcoKSBhbmQg
b3ZlcndyaXRlcworCSAqIGtjYi0+c2F2ZWRfaXJxZmxhZy4gV2l0aG91dCB0aGlzLCB0aGUgb3V0
ZXIga3Byb2JlIHdpbGwgcmVzdG9yZQorCSAqIHRoZSB3cm9uZyBEQUlGIHN0YXRlIGFuZCBsZWF2
ZSBpbnRlcnJ1cHRzIHBlcm1hbmVudGx5IG1hc2tlZC4KKwkgKi8KKwlrY2ItPnByZXZfa3Byb2Jl
LnNhdmVkX2lycWZsYWcgPSBrY2ItPnNhdmVkX2lycWZsYWc7CiB9CiAKIHN0YXRpYyB2b2lkIF9f
a3Byb2JlcyByZXN0b3JlX3ByZXZpb3VzX2twcm9iZShzdHJ1Y3Qga3Byb2JlX2N0bGJsayAqa2Ni
KQogewogCV9fdGhpc19jcHVfd3JpdGUoY3VycmVudF9rcHJvYmUsIGtjYi0+cHJldl9rcHJvYmUu
a3ApOwogCWtjYi0+a3Byb2JlX3N0YXR1cyA9IGtjYi0+cHJldl9rcHJvYmUuc3RhdHVzOworCisJ
LyoKKwkgKiBSZXN0b3JlIHRoZSBvdXRlciBrcHJvYmUncyBzYXZlZF9pcnFmbGFnIHNvIHRoYXQg
d2hlbiBpdHMKKwkgKiBzaW5nbGUtc3RlcCBjb21wbGV0ZXMsIGtwcm9iZXNfcmVzdG9yZV9sb2Nh
bF9pcnFmbGFnKCkgdXNlcworCSAqIHRoZSBjb3JyZWN0IG9yaWdpbmFsIERBSUYgdmFsdWUuCisJ
ICovCisJa2NiLT5zYXZlZF9pcnFmbGFnID0ga2NiLT5wcmV2X2twcm9iZS5zYXZlZF9pcnFmbGFn
OwogfQogCiBzdGF0aWMgdm9pZCBfX2twcm9iZXMgc2V0X2N1cnJlbnRfa3Byb2JlKHN0cnVjdCBr
cHJvYmUgKnApCi0tIAoyLjQzLjAKCg==
