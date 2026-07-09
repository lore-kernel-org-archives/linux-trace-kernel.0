Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022140.outbound.protection.outlook.com [52.101.126.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B1B1C84CB;
	Thu,  9 Jul 2026 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606947; cv=fail; b=fLxw3EZa6iSo+BDNAY6pOgAQeNS+Bu3lpGWpUX84dwhuoPwfJSgyOKkO8pB/uyiXKIn2d5pnY/kxX7deAndPGLgHhvFLe51/r8YHiQufIVTcl8Vy2Y6a0lPlJjqabVSLhf6rXHtgW5PCUEZ3H/4kzKfoeiE1SewE+izQCFvn1hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606947; c=relaxed/simple;
	bh=SxXLVu1/vXtttZnWYscSbPwgcWBJUlyDrz2gZ8o3iBY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NkMN0Wlol4eawFcuWsVp65PLHSDpV4jl06wMuMpdpj2TwnvfIErzlecgwxeYiiLptaKYKFVjcqUvCORQgnZGnXtk+0N61C0QYKA9diB2xOffTEpdYcU8HHrhHr0CBVEnv3JWVOnQKrwsLfUU7w4mJCAxzB4d3jfW3sWnh0q9I5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=T1kUko7J; arc=fail smtp.client-ip=52.101.126.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="T1kUko7J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDun73pX4WvfC3cZP+m6MyWObaMXVCFikGFr93K4BAKBKlpamJq0WvfLCd+v+U/z2hfaKL2Jq/zclq7/gFRJ1zhADhxKb4USrzg4Y2APRHYUYhNzfTdPagqIBYrnaKZhJ3mYrhyjl+O0/SAJgEAd2VpUHw+HGNEZXTvOd0/gTRtAJhh2h5x3sDL9Ddhd+ENy1XG0QwA6uNu5gDQUGSqrd5B/YE4dJajSF277lj4mszdR/FQ/U0jWNAu/HVpF8MQU3YgvHAW5P4TWMVj0dfTXTE2uZTd5mUtjTfeXJDHZuOTAjhbIF95YSwxwM6uwPJ9kYhbKf1d+/srK5PO/q6Ri2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxXLVu1/vXtttZnWYscSbPwgcWBJUlyDrz2gZ8o3iBY=;
 b=Y3MN5OH6FpN275C9r52w6nJ9RVgR57L+yaLOsaoUf76RKuBPpxs1cvCUSfmjRfZwhGdQz1VpwJ2hALkkRojF/IwVQ8A+kHv4e5Ub5aYHUg2K7kialMh4EE1Shk0YP8XAAsxyJVsGhb/9CZTD5UfMsbZMO7OOgexouLf5FxEbOZLijZh+YHQu/FiY4mJn0pHfrIEsptU3DD+P+NV0CkTgJjFTu0OK6+I8bbQR2KxbZX5FLo6XRmlTuYFdB1mFORorrfZJAvLSAV4DMWWTl19+ss8YY1FqM9kR/8gOkPEm5QolpzdiyV/GWzE9SKz7SrJRzyn0UawQF9etrsSQR+A4Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxXLVu1/vXtttZnWYscSbPwgcWBJUlyDrz2gZ8o3iBY=;
 b=T1kUko7JW3xdSlo0FwvKkEv0K936jMLPSPwNpfvCS1hih2iDAq1VZHberTT3cvd+I9ww6Tsx5KWWaaHYu6ExuXV1nCeFfttdYJwNtLtF11HMWx8oEZEtivoy/MbEqdKNWt2NOceB5PgID0R6IO5uiOk+OKF33ImDC3pDoHJ1vL8=
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com (2603:1096:4:1a4::11)
 by JH0PR04MB7844.apcprd04.prod.outlook.com (2603:1096:990:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 14:22:22 +0000
Received: from SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d]) by SI2PR04MB5648.apcprd04.prod.outlook.com
 ([fe80::8ce1:b82b:3b19:f79d%5]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 14:22:22 +0000
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
Subject: [RFC v2 0/3] arm64: kprobes: Fix single-step fault and reentry
 handling
Thread-Topic: [RFC v2 0/3] arm64: kprobes: Fix single-step fault and reentry
 handling
Thread-Index: AQHdD65bdB2sBmrgr0+oRCdOEc3LiA==
Date: Thu, 9 Jul 2026 14:22:21 +0000
Message-ID: <20260709142215.226872-1-hupu@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5648:EE_|JH0PR04MB7844:EE_
x-ms-office365-filtering-correlation-id: e5c64515-359f-45c8-4db9-08deddc57de6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|56012099006|6133799003|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 H/S+OykEi71C1klrqLVT/c1iIyhp6sVCXApGOEZ5wklc7vfcQ/NqPDa5FUSCNArFnUxYqxXUlg2AGq7jL6lBTqYCUdinSH7AsR7ihQhARBYjlDvYx2i+cz2ZPPJTnfIgr0XKGVbQW+Hty3zpESAoMUAcg9JesHEjXA3fGGlrP4kO0BkTJVApg7cwEM0+gd1ILFvdxCGc8mTc/kQNbehiC7vFqRFyMO7YjA7X7kvYLysyH5rRBoejDv5dk7rpYdSnrB5kKIq7nnJn7nrkcs29FIKMyYm5TmDz+z4n98PKPSwRIVnAcNCtUK4Be2i1mXHPMMvzTC5pfg04tpnMmdtBo2CYcbiu9lDqeYjdM7z3WTGzCJXU+SicOfQPNcaGR8/AtBFYGDlInKTmUUpRyi+eZr7ZyGH25rLULfp38Oh13QNTaCErH3QrJpR95x6mcZalVkdysdqN3pOKpeKMEevrybzD5/K6sw2X1u6Fw5Y8dW8UQORNz6pX6VHiVX93EcuSAwuUKkM2vK7sZZFlX5DYcIwBOJcp4+02uBXdJW5bDzrMOdZib0iP/MDe351sUpMRHOtFy9MkrfuvXGbZTzkGl3gH2nZMSPc2b/jDA7IqL/kWq2M4sVrjja+oqy2qeQOmW+cvH6PpZzSihlOBqFM4Yx+tz/6Jw3PHDArWmwc7jvBiLg6XngXB2Z4x6ttCfk0bU71Xb1u/l0XJCjQiZggv8nZ2pSOi82GHxHwrA5MnhMo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5648.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(56012099006)(6133799003)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZURkS2lIK3E2alhKSWovNUhQMVhaMGI0cWZJSXRBbVB2bmpLRm9vRmhsUDlT?=
 =?utf-8?B?a2tOdTlDQ1NvNTA3dGlVcmtTcVFpbjZ6NUtnaGZTRTNLczQrT003dUV0QUtH?=
 =?utf-8?B?Z3NlZVp1QlZWMm9VSWtKV3kvaWRKd2Z4NVNIRVE0WTFiQnNidTNWdTNjNG5S?=
 =?utf-8?B?QS9nY1VkQUlGT1ZVTmp0eWZTYU1tZHZjeVgzY0xQRjRQWnlsbUNUYmhId0RV?=
 =?utf-8?B?cFY2ei9HQU1FR2dmNXkwTmtjU2J2SUp6eDlXUWFiQUgydS8zcStQZ2d4MitV?=
 =?utf-8?B?bDFKQlVIQndCSlZiWXB4TWxXdlh5QW8vMzh4Qm10SzFCWndGY1BwQXN1SUJo?=
 =?utf-8?B?NElEQ1RVMGV4N09hTE4yWEZHVFBaSnlPLzZiVm1qcWkrVE5FdGRqdjU4bXln?=
 =?utf-8?B?cXpORHdwdTd3QzMybWExZXd2THpQMG1pQmdJSFlnSC92RGU2ejlVOGFpbWVa?=
 =?utf-8?B?YzR1VFZVTkVtVWNIVi9ZYVZOVVBwU1AvYXhjRi9YV2N2elhDREF3WmV6V2ND?=
 =?utf-8?B?S0xMem5jUFdiMm93RjlQVjlRWnYyeVI1QzREVjRGVlhGdUVpQ25nU3VCamFZ?=
 =?utf-8?B?Zk9ST0RhdGpSY1VzaTF0MFZxa04xUWYyV3d3ZE9OMnI4MXY2YnR0bHoyQ3Bz?=
 =?utf-8?B?OTJwRTBzT05uOVdQUkJEalpWYTRLSHc4UEhsSk92Q0N5T3U2elZmM1o5QmQv?=
 =?utf-8?B?TGt1L25uc2tHUTJudkc3Szc1NVNJOG8wY2gzYmptYmhkei80Q0YwbHpFUUk0?=
 =?utf-8?B?b1hUSzZlVkdhUHJPUlZmbWJ6WTlQeHdXZXNvZU54T240b2ZleXc2MEhaL05q?=
 =?utf-8?B?aU1MSlZGd0FPVGlLVkNsdUQ5WTJWYWVVSUprUmphQ0dDQitwQzVvTkVNQjVp?=
 =?utf-8?B?UVNjSEZ1L3E1OHNjcU40OUdPRTFkdGZBN2xYRG1LcGRmcVRLeVRaTCtCY0lU?=
 =?utf-8?B?NmRQS3VkaDJpRUVpekg4QlFqOVd2bUhBQ0VheC9wemhVUEJQRjg2eThPMmJh?=
 =?utf-8?B?Mmx4OGZWcVZvcEVvMWFuMVpnY1BXU0Q2WitzQjYycm9GUlJNdnp5aVQ4ZVdD?=
 =?utf-8?B?OEJkZ3ppc2Q1WEMvTmxPS3RGa0tEV0xrQnR0cjRyV2tndW1pKzRYamhEdWNo?=
 =?utf-8?B?T2pYWk1iS3p4eVdDNnlJWldyVktPOXhnVTNmWk85Q29Ja3ZUdWM2MlE4N1pw?=
 =?utf-8?B?eW1lVFZEMVlTcU5yZG9nSnNlcUtGVkhmekhYYjVzemlhL1p2U2NUdG82MGRi?=
 =?utf-8?B?ejFlVkp1elFFeHFaRGdJeWpqOWVra2pWS3BHekdjbFcwcCt5STBEMGYwdjNY?=
 =?utf-8?B?Ym1DeFhnWVpJR0lxNEpSdVZTc3NuNGFLaDJsSjRnOWJCdlpmRXFoV1hVbElZ?=
 =?utf-8?B?b29nY3FtTWQyTzZwZEQxeE5KZC9JcHdpT2tYQnY1U1I5MzZrN1RXNzJhc2c5?=
 =?utf-8?B?YnozS3ppNTdtMzgxRWJyL1IvMURaNlJGbEdzOVRpZFlwZXZiZFJEMnE5UURM?=
 =?utf-8?B?NGVVdlJpMnNUVnhqb09hejBnRkdjUmNRZUJOMXdMWmN1R1ZDZjlzNlkrcmlR?=
 =?utf-8?B?SGl0VEVUUWhyVEVYMy9oVERvcDV2T2ZBb2VVd1lkR0NBUVZ3YjdyNVRJZ25X?=
 =?utf-8?B?enFRa013R0NLa2x0am8vNjhRbytoL3NKNHdOTnh0WFgvem9NTjQxUkNhUkpK?=
 =?utf-8?B?U3FHNW9iODFpbXBkc05BejZkdWtHWTZNMmJmdTBSQjd3Z0IxNDRWY3NLVXh0?=
 =?utf-8?B?WFZjVjNqd2d3VGZDWTZDZlpkZldKbFdBS2YwNFZFS2VxdUFCR0VOSlQvczBK?=
 =?utf-8?B?RGt5SVhNc1V0SStMdnhlbXloREFHKzllMEZnbm9FYk9uWEhTT243dUk4cmNC?=
 =?utf-8?B?WmFLM3dBNWVFZ2trMTJ3NGRoemJsMzU0UVFzSVFidCt4QVZycDgyd3VRWEZj?=
 =?utf-8?B?N1dyLzEwSkVrY1RlMnF6S1dyU21aUmRtT1lVakRqR0NmbkZDbUlmNVpBVUR1?=
 =?utf-8?B?MU5GT3pBNUZTYXVsc1dNUTdFcmVwNlhucFJQZGJ4NCtEU0pUUGpSVGZYOEo4?=
 =?utf-8?B?MGYvd3NRUTVKdFlzUGpLNGo5RFZGWFJwYlkwcW1lZEg0YndhOTEwZ2w0SnBz?=
 =?utf-8?B?U09TaUplcldoNktYZFZYS0VIekxkWlVpKzQxRzhTSUR2VzJVak41UVYwanIy?=
 =?utf-8?B?dHBQaGFWa3BDMGVhRlRnNXlCbGdBWGpJdW4xSmgxeFdNZm1PT0hQVithZDdS?=
 =?utf-8?B?OE5CalRDcTA3MnpEejlNelFYYjJzMEd5UVEyM05LT09vRkxUeXJMcFkyUElD?=
 =?utf-8?Q?/kOjvpJHc8TDV6VgKV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c64515-359f-45c8-4db9-08deddc57de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 14:22:22.3326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/0PjgSX1rHUvUr0bd9aXI/eKcnK2GyOzZyHBjtfIe+YpT4lyyRszYAdW7bvhO+zfL3KVGdMwK48f4znArwvgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7844

RnJvbTogUHUgSHUgPGh1cHVAdHJhbnNzaW9uLmNvbT4KClRoaXMgc2VyaWVzIGZpeGVzIHR3byBh
cm02NCBrcHJvYmVzIGlzc3VlcyBvYnNlcnZlZCB3aGVuIHJ1bm5pbmcKc2ltcGxlcGVyZiB3aXRo
IHByZWVtcHRpcnEgdHJhY2Vwb2ludHMgYW5kIGR3YXJmIGNhbGxjaGFpbnMgd2hpbGUgYQprcHJv
YmUgaXMgYWN0aXZlIG9uIGEgZnJlcXVlbnRseSBleGVjdXRlZCBrZXJuZWwgZnVuY3Rpb24uCgpU
aGUgY3Jhc2ggaGFwcGVucyBpbiB0aGUga3Byb2JlIGRlYnVnIGV4Y2VwdGlvbiBwYXRoLiBXaGls
ZSBhIGtwcm9iZSBpcwpwcmVwYXJpbmcgb3IgZXhlY3V0aW5nIGl0cyBYT0wgc2luZ2xlLXN0ZXAg
aW5zdHJ1Y3Rpb24sIHBlcmYvdHJhY2UgY29kZQpjYW4gcnVuIGluIHRoZSBzYW1lIHdpbmRvdy4g
VGhhdCBjb2RlIG1heSBlaXRoZXIgdGFrZSBhIGZhdWx0IG9mIGl0cyBvd24Kb3IgaGl0IGFub3Ro
ZXIga3Byb2JlLgoKUGF0Y2ggMSBmaXhlcyBrcHJvYmVfZmF1bHRfaGFuZGxlcigpIHNvIHRoYXQg
aXQgb25seSBoYW5kbGVzIGEgZmF1bHQKdGFrZW4gaW4gS1BST0JFX0hJVF9TUyBvciBLUFJPQkVf
UkVFTlRFUiBzdGF0ZSB3aGVuIHRoZSBmYXVsdGluZyBQQwpwb2ludHMgYXQgdGhlIGN1cnJlbnQg
a3Byb2JlJ3MgWE9MIGluc3RydWN0aW9uLiBTaW11bGF0ZWQga3Byb2JlcywKd2hpY2ggaGF2ZSBu
byBYT0wgc2xvdCBhdCBhbGwsIGFyZSBmaWx0ZXJlZCBvdXQgYXQgZnVuY3Rpb24gZW50cnkgc28K
dGhhdCB0aGUgbm9ybWFsIHBhZ2UgZmF1bHQgaGFuZGxlciAoaW5jbHVkaW5nIGZpeHVwX2V4Y2Vw
dGlvbikgY2FuCnByb2Nlc3MgYW55IGZhdWx0IHdpdGhvdXQgaW50ZXJmZXJlbmNlLgoKUGF0Y2gg
MiBhbGxvd3MgYSBrcHJvYmUgaGl0IGluIEtQUk9CRV9ISVRfU1MgdG8gYmUgaGFuZGxlZCBhcyBh
CnJlY292ZXJhYmxlIG9uZS1sZXZlbCByZWVudHJ5LCBpbnN0ZWFkIG9mIHRyZWF0aW5nIGl0IGFz
IHVucmVjb3ZlcmFibGUuClRoaXMgaXMgc2FmZSBiZWNhdXNlIHRoZSByZWVudHJ5IHNhdmUgYXJl
YSBoYXMgbm90IHlldCBiZWVuIGNvbnN1bWVkIGF0CnRoYXQgcG9pbnQuIE9ubHkgYSBoaXQgd2hp
bGUgYWxyZWFkeSBpbiBLUFJPQkVfUkVFTlRFUiByZW1haW5zCnVucmVjb3ZlcmFibGUuCgpQYXRj
aCAzIGV4dGVuZHMgc3RydWN0IHByZXZfa3Byb2JlIHdpdGggYSBzYXZlZF9pcnFmbGFnIGZpZWxk
IHNvIHRoYXQKdGhlIG91dGVyIGtwcm9iZSdzIG9yaWdpbmFsIERBSUYgc3RhdGUgaXMgcHJlc2Vy
dmVkIGFjcm9zcyByZWVudHJ5LgpXaXRob3V0IHRoaXMsIGEgbmVzdGVkIGtwcm9iZSBmcm9tIFBh
dGNoIDIgd291bGQgb3ZlcndyaXRlCmtjYi0+c2F2ZWRfaXJxZmxhZywgYW5kIHRoZSBvdXRlciBr
cHJvYmUgd291bGQgcmVzdG9yZSB0aGUgd3JvbmcgREFJRgptYXNrIG9uIGNvbXBsZXRpb24sIHBv
dGVudGlhbGx5IGxlYXZpbmcgaW50ZXJydXB0cyBwZXJtYW5lbnRseSBkaXNhYmxlZC4KClRoaXMg
Zm9sbG93cyB0aGUgc2FtZSBsb2dpYyBhcyB0aGUgZXhpc3RpbmcgeDg2IGZpeGVzOgoKICA2Mzgx
YzI0Y2Q2ZDUgKCJrcHJvYmVzL3g4NjogRml4IHBhZ2UtZmF1bHQgaGFuZGxpbmcgbG9naWMiKQog
IDZhNTAyMmE1NmFjMyAoImtwcm9iZXMveDg2OiBBbGxvdyB0byBoYW5kbGUgcmVlbnRlcmVkIGtw
cm9iZSBvbiBzaW5nbGUtc3RlcHBpbmciKQoKdjEgLT4gdjI6CiAgLSBQYXRjaCAxOiBtb3ZlZCBz
aW11bGF0ZWQga3Byb2JlIGNoZWNrIHRvIGZ1bmN0aW9uIGVudHJ5IChwZXIKICAgIG1haW50YWlu
ZXIgcmV2aWV3KTsgcmVtb3ZlZCByZWR1bmRhbnQgeG9sX2luc24gTlVMTCBjaGVjayBmcm9tCiAg
ICB0aGUgaW5uZXIgYnJhbmNoLgogIC0gUGF0Y2ggMjogdW5jaGFuZ2VkLgogIC0gUGF0Y2ggMzog
bmV3IGluIHYyOyBmaXhlcyB0aGUgSVJRIGZsYWcgc2F2ZS9yZXN0b3JlIGdhcCB0aGF0CiAgICBQ
YXRjaCAyIGV4cG9zZXMuCiAgLSBSZW1vdmVkIHRoZSBzZWxmdGVzdCBwYXRjaCAob2xkIFBhdGNo
IDMpIGZyb20gdGhpcyBzZXJpZXMuCiAgLSBGaXhlZCBTaWduZWQtb2ZmLWJ5IHRvIHVzZSBmdWxs
IG5hbWUgKFB1IEh1KSBpbnN0ZWFkIG9mIHVzZXJuYW1lCiAgICAoaHVwdSkuCiAgLSBVcGRhdGVk
IGNvbW1lbnRzIGFuZCBjb21taXQgbWVzc2FnZXMgYWNyb3NzIGFsbCBwYXRjaGVzLgoKUmVwcm9k
dWNlcjoKICBzaW1wbGVwZXJmIHJlY29yZCAtcCA8cGlkPiAtZiAxMDAwMCBcCiAgICAtZSBwcmVl
bXB0aXJxOnByZWVtcHRfZGlzYWJsZSBcCiAgICAtZSBwcmVlbXB0aXJxOnByZWVtcHRfZW5hYmxl
IFwKICAgIC0tZHVyYXRpb24gOSAtLWNhbGwtZ3JhcGggZHdhcmYgXAogICAgLW8gL2RhdGEvbG9j
YWwvdG1wL3BlcmYuZGF0YQoKQmVmb3JlIHRoaXMgc2VyaWVzLCB0aGUgY3Jhc2ggcmVwcm9kdWNl
ZCBmcmVxdWVudGx5LiBXaXRoIGFsbCB0aHJlZQpwYXRjaGVzIGFwcGxpZWQsIGl0IHdhcyBubyBs
b25nZXIgcmVwcm9kdWNlZCBpbiBvdXIgdGVzdGluZy4KClB1IEh1ICgzKToKICBhcm02NDoga3By
b2JlczogT25seSBoYW5kbGUgZmF1bHRzIG9yaWdpbmF0aW5nIGZyb20gWE9MIHNsb3QKICBhcm02
NDoga3Byb2JlczogQWxsb3cgcmVlbnRlcmluZyBrcHJvYmVzIHdoaWxlIHNpbmdsZS1zdGVwcGlu
ZwogIGFybTY0OiBrcHJvYmVzOiBTYXZlIGFuZCByZXN0b3JlIHNhdmVkX2lycWZsYWcgaW4gcHJl
dl9rcHJvYmUKCiBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL2twcm9iZXMuaCAgIHwgIDYgKysrKwog
YXJjaC9hcm02NC9rZXJuZWwvcHJvYmVzL2twcm9iZXMuYyB8IDQ1ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQogMiBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgotLSAKMi40My4wCgo=
