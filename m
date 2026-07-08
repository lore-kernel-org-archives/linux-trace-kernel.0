Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023090.outbound.protection.outlook.com [40.107.44.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7BF3E63BB;
	Wed,  8 Jul 2026 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494785; cv=fail; b=S+SpZAoyWQkD8N3yKzJ8qGEg9iM8UokqfNvxJ79NzocNFAIaArQ5F+qBN2zCZKsLMiod9fwZCyLcVcc0zE17Y7fLP8ReIu5uQRuyFibSx5krNQ/C5Nh8GBLzSz2xctWrHCXRsBoLXlfOPlSKEUJ+lHa+sH+IHQTk2a70GsvVzMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494785; c=relaxed/simple;
	bh=24/0Ppc2uU09rWlNoBNXeBIoN6Q8In6VyGgaQmw+igM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ONgrNZ0W/ZtuJ1TedAOhav8+tpCnlx2roYKKWMBGG0jWOMmyED5Dsf3P1AOoRWDmPExPh0/2X/vHZ+HtEsO92p+6Xx7cx6t6J3CqKGNdLBDKBkJPMxQHk+HkTwpxHV8Jmog6HnY9+9+CNT6XKbOZp8grAKNyVxKyGJpjJtL0e2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=px1j/uqa; arc=fail smtp.client-ip=40.107.44.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="px1j/uqa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipUmwWNtlwyYv/0f30AXYP59MFbbou5QWO6ANQMrelFmgrD+0cTcXvyUln1cPAIdZgQKi8G20ODJ8Mg4M+73o2hdV+lq8lxtrLxR369+VbUgBXBkQHLejEUQ0YJgwIvjhy1IoGwoFOpPgb30owGY+2Yn9n7E0Z3akaW5sVisV7WFLzfdNhRgTrCT/TbnD3W7w+gHl3VXBHww6yp4F+sV+IOU+77VbyedSNMZHRZEYXufCA5SRuvLeyx3uMTt29XLsSPUpRuGyEk6DKQsTaVG8RHz4uo07xpz5cdu4MozwAynDesSx6r+uP8cVi0bDL9JruzBV2coEltjP4HVvLsIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24/0Ppc2uU09rWlNoBNXeBIoN6Q8In6VyGgaQmw+igM=;
 b=Qvr0dd5eNJb0ixWBXvyeKP6/9spG8Drx9IUzHSqGV1tcyu4FxHTza7/vXSZ/EvSDeKF2i5xt1N+WlFUscXXpLVBAxQERlqpVrBhkyG6+j3o7yAq6WqbzTe3Mrzi4WTZbGKOsblIk5F37L3tPY2ld0L1alGVH393G+e9UG7TABLAIuZgPk6dF7emeBvkV4YvHhX468IpYg+Ml1IXi85KGWwAyCYkvQ04iKluh1VlyJndd1aICRs12lv4lXvLStJWWtPNJOpNiXC13CS/iaosHJcHnsT0Qt7t/H+4nIAcs5YXX8nfo9DzRoHPt3p/NiWiAB1EUisW0RUV8KPxqaNh5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24/0Ppc2uU09rWlNoBNXeBIoN6Q8In6VyGgaQmw+igM=;
 b=px1j/uqaWZqQHGW35ktljHPb1loGptCb0MwKCzLAjlMGafS15ITk3ov/AbBNLMF39YWFxin3FebKe/SiWfiEVgRS7zf6CPCzApPkIPYrU17J7q7rUu22gPFgmZN/ClaRxJW10pT0Ug/txRM6EhbPfug6gUkmQeNJZ2Wg9gvVHO4=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by TYZPR04MB8180.apcprd04.prod.outlook.com
 (2603:1096:405:a3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 07:12:39 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 07:12:39 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Pu Hu
	<hupu@transsion.com>
CC: "ada.coupriediaz@arm.com" <ada.coupriediaz@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Jiazi Li <jiazi.li@transsion.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
	<naveen@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>
Subject: Re: [RFC 2/3] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Topic: [RFC 2/3] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Thread-Index: AQHdDSKXepCfzBeAOkWqXMhfNTq6JLZizkEAgABpqoA=
Date: Wed, 8 Jul 2026 07:12:39 +0000
Message-ID: <68189403-9728-4938-8ee2-924e4702eab7@transsion.com>
References: <20260704234730.46d51c47d75e7d208e7bec9f@kernel.org>
 <20260706083636.159883-1-hupu@transsion.com>
 <20260706083636.159883-3-hupu@transsion.com>
 <20260708095400.7582bc9589fd9da925aa9c1d@kernel.org>
In-Reply-To: <20260708095400.7582bc9589fd9da925aa9c1d@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|TYZPR04MB8180:EE_
x-ms-office365-filtering-correlation-id: 728477bd-15d7-4985-05f8-08dedcc04b87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|38070700021|6133799003|22082099003|11063799006|18002099003|4143699003|56012099006|4133799003|3023799007;
x-microsoft-antispam-message-info:
 f16gPvFSF9EE34fPuMqJBPIqqVQrrm2ObJqxigavHy0S+R6daqPoC3qiZPFK+D3wlMw25afa+agAUI1DaMPPwjU7yuoQBBXwDgZp6wGjsJiy481c2464BoZ+BuZNKESAWCgKM7fbX12gYwvtibODeinkscpRdQBkYZ/pV2fiqeAEMg+2EZTGtyKpptR8cVtUEziHHGxEl8Rf5S1SthPsR6hu00dlbfPHDmB+6anPeGi/zqrZKVbN2m5iimH1Wx7yO+YoUOQZ3cLZbz1gG+5OfLcjjv1yIG3m5q4vFNp++qG/WLwNnCxFgFJugNQdX9YqUQTnUc77AK9sISNG2FYL3mYQtQVWFRfYRyLn4plmTayIbWSPI52A4B0GpfL9aQcM/UgCVewYddPq1SZLKcXfY9LIxII+QY34m0hYhICtHC5zJ8rptb3K4DLJO5u4WHoLy1cQH8tXDqIZqbTVmSzjU0AJcUKyVYFRaACpydFTnUVkZq5TseO67rgdZUyzdKZetec3bN03Mi76BjBUukxQTzNCqIEQGx6j104sJfHgbPKUX2ksOAHJuMH2xrBfrURwbB/eUJFguv8EdOKX77LuaP5x/AAW30eGMltESah/1M7+b4ssIvNNGoJsK2b4xv2NCjbOKgZDgRF3b7C1z3K+pRmUdn77DSwPKG6Nqi/iykE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(6133799003)(22082099003)(11063799006)(18002099003)(4143699003)(56012099006)(4133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlVtRkFSTHk3bkhnQjNDNEpFSUJoRnJyYW50VlZnaTNaWFFmaHhNc2JkRkRp?=
 =?utf-8?B?SG01eFRtTldESldqOTlWVHBKUkpHMFZXajFMdWVXY05SL1oyWmFZMjlDdHc0?=
 =?utf-8?B?bmdTQXkxaTlGY3VqNzQ3ZVNsTDBIRS9xUDdoOFFmWW1LcU5TbVhJeFhGWnpZ?=
 =?utf-8?B?dFNRd1R6bmtxdkVPcndnM2xrK09oQis4RDBLUElQbWwxWmx6UXJYc2hnSnhT?=
 =?utf-8?B?YUw1N1Uyc3ZlS2lybHdNY2xVZUcxVWt5UnZmVDJzejM2L053eHl5c1BtMFk3?=
 =?utf-8?B?N1JNNEJmZXcyZnBEZ1JyUDdzMnU3UUdjU1dxU3VWTHgyUVNHaFdPbU95QVJ1?=
 =?utf-8?B?MWVQQUgxRlhxTzRzekM4anFPTWdhRGh1K1AwM09DdWlWVEFUcXVaY0xpU081?=
 =?utf-8?B?K0hYYXlydElvNmhrNXEyNGhCOXUveEVHTG5GcHB4ZWt6UWlFa1dya0FZVldr?=
 =?utf-8?B?eDFhT29HRXlPM3FiQ0Rqelkrdk5TeklQdHBiWHBOcm1DRVlUZDBDZm5CVUZ0?=
 =?utf-8?B?TytNK3hyaVpYaE9ES0FIS2NLaDk2ekpFZWowanRiR2g0Q2FlWTBFUk5mbmF1?=
 =?utf-8?B?VFd1ZEZoNGptbzZqYUxzc01zRHo4REVaQmFRekZ5MkZBYXNablp2dm1aOGFm?=
 =?utf-8?B?QVFteDNlMS9CVVFlWnZVNUNPNlg2cTV1TUtORWhIVWlVUytZNVYwTzAxUms0?=
 =?utf-8?B?a0NyRDA2WU9PWmd6c3NDLzBEL3VFa2tHUzFvcE0rYXIyY29sbVRVVVUreFdj?=
 =?utf-8?B?b0drSXBpOUdpbXY1S1ROaGdmZWMzWHNzYjQzM0RNOGI5dXhHWTI1T2pyTGRZ?=
 =?utf-8?B?S01ZMTdEb2xZYTVGeWViT2xPdldqeDIrWDJodk1mcVNCK1hsaDQ4Q05qb1c3?=
 =?utf-8?B?M05MZ3BOWG1HTVhVOVlGdkpoVm55Nm5iaWFvZkprV3NYYlNWWUlCSDRYVVNS?=
 =?utf-8?B?STV6UlJHOVg0WG92M1JhMzdjRDlPejBJMkVpWmE5dENQVDlVSlZ0RldmeFZV?=
 =?utf-8?B?QnprRjZoVlVrOEpLTGI4WWIrVVlaQ1NobE9IODFMa0dEcVQ5Z3diTm1ObzE3?=
 =?utf-8?B?cU0xanVhbThjWXJmTnlGeGtUQ0tBRG1Ld3pqdDZPTlo1SFdxc1puOXRiWUNU?=
 =?utf-8?B?QXpXRzJGUENuYUs4dkMwNmY2amgxTWhkbDRaWnpLQnhGejE2Lzc1YXNlWGlR?=
 =?utf-8?B?THRPWk1zZU1nNTNzaGFmeU5TWHNTQjNxWjN4UkxyNy9memFhcWgwYVBaemx0?=
 =?utf-8?B?SC8wdE10ajZQMXBJdkN5Z0dxVDR3Kzk3MEJ2R1NRejZsc1VOTmFZdW9GeEZ2?=
 =?utf-8?B?bzVYVDRPV256ZmFjRG9nUEV4OE5kYXpyVUo0KzcvbG1MVzQrdmVEbEl3U2VL?=
 =?utf-8?B?aHpxeDNqVU84L29WdVBZOWFKT0dhTkZ4a0FuKzdMQnFZMlpOdmpwcVQydklL?=
 =?utf-8?B?SDVJRW5wWVRIZ21oS0VOSXdnVUdHVlJVVWhQcXpGejRpREVaWGNkdWFleWRz?=
 =?utf-8?B?RThPaldUTmQxem1PVDMvQjd3K2JBUjJOWDdXZXk0MGQwWHhtSUZlbHc4c3ZM?=
 =?utf-8?B?cmRnaGhMRTgrMVc4V3dVdnpiYzUrWDhLSTZNUzh6WGM2YlpENUIxajhNVHRO?=
 =?utf-8?B?WkVIbzBKMENMRGtkWnUxY1l4cUxwU0xXUGYvVkxzbFVWVWVNaDhPT0VYdUxo?=
 =?utf-8?B?cFd1L0w0NFVub0pxSlBRVUt5Yzd1U3lLK2Q0bWVwUE5idUcvNDA5T2RyM055?=
 =?utf-8?B?TCtIU3VvcmdmcldId1FyVkwvdi9zZzhscDlvYUVWUldoTDl0eFNZRWFsc0h6?=
 =?utf-8?B?SkRSMWxoTlZqckZ1YjQ1M0ZNZDVPa2ZxTFlJaW1NaTNaR3A0dUc3NlpEN05L?=
 =?utf-8?B?UDVLVU1IN3JjaytzVGs0SXpuY1dHaFcxQXhTR0tuKzcwd3pCOXg1Z2RDOTZo?=
 =?utf-8?B?Z2VjWHR5Nkx2WmF1UFc4QlRwZnRqWGZwZVR6TFRIS1FMeVlNampXalgvcm15?=
 =?utf-8?B?eUN0SkovdGNZSURlM1NjNFZ6REc4SlhJSytlSXZkL091UEpwYStQTWFCeEJ3?=
 =?utf-8?B?eU5UNGZjVEgvTGF2ZzZGa05ONEhyVEZPbGFmOEd1WDVUNG0rcXFxSXpxRlZx?=
 =?utf-8?B?MWgyVzdRQnJrWVZzeU5tcmVTOVZEV3RNbEU1ZXh1MUc0dkkvdzIwN2tTUHFW?=
 =?utf-8?B?NHo1OGpVME5nRmhaNXh6Y2I1NkNEejRJcFArWERxc2tIbGNqUWQwYnVUUjBx?=
 =?utf-8?B?aVViSW5rMW9jTjFjbGtzYzdGT0sxbUd0a0JBNUp4R0EyZnhjQ1FDRzllUGR1?=
 =?utf-8?B?NzBGcDI0WHh6dWlBVSttYm9mQ01nOW9FUUMydWJRZVFiUlBnN2dNU0hNanVz?=
 =?utf-8?Q?y+wlsEHE/iQjwI1U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F1C6D048112A84BA56B91654FFD28E2@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6196.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728477bd-15d7-4985-05f8-08dedcc04b87
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 07:12:39.1536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snwaOxQAtJmNn3KkJ74nQBO3qHX8nqmEsZaUjHvppes0JHCe1ZaF3cFL9YfNn+SABWNDwOXphfQzayREXqIA34tKJnF+HUeyw1R1+3S3PYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB8180

T24gNy84LzIwMjYgODo1NCBBTSwgTWFzYW1pIEhpcmFtYXRzdSB3cm90ZToNCj4gT24gTW9uLCA2
IEp1bCAyMDI2IDA4OjM2OjQ5ICswMDAwDQo+IFB1IEh1IDxodXB1QHRyYW5zc2lvbi5jb20+IHdy
b3RlOg0KPg0KPj4gRnJvbTogUHUgSHUgPGh1cHVAdHJhbnNzaW9uLmNvbT4NCj4+DQo+PiBBIGtw
cm9iZSBjYW4gYmUgaGl0IHdoaWxlIGFub3RoZXIga3Byb2JlIGlzIGluIEtQUk9CRV9ISVRfU1Mg
c3RhdGUuIFRoaXMNCj4+IGNhbiBoYXBwZW4gd2hlbiB0cmFjaW5nIG9yIHBlcmYgY29kZSBydW5z
IGZyb20gdGhlIGRlYnVnIGV4Y2VwdGlvbiBwYXRoDQo+PiB3aGlsZSB0aGUgZmlyc3Qga3Byb2Jl
IGlzIHByZXBhcmluZyBvciBleGVjdXRpbmcgaXRzIG91dC1vZi1saW5lDQo+PiBzaW5nbGUtc3Rl
cCBpbnN0cnVjdGlvbi4NCj4+DQo+PiBDdXJyZW50bHkgYXJtNjQgdHJlYXRzIGEga3Byb2JlIGhp
dCBpbiBLUFJPQkVfSElUX1NTIGFzIHVucmVjb3ZlcmFibGUsDQo+PiB0aGUgc2FtZSBhcyBhIGhp
dCBpbiBLUFJPQkVfUkVFTlRFUi4gVGhpcyBpcyB0b28gc3RyaWN0LiBBIGhpdCBpbg0KPj4gS1BS
T0JFX0hJVF9TUyBpcyBzdGlsbCBhIG9uZS1sZXZlbCByZWVudHJ5IGFuZCBjYW4gYmUgaGFuZGxl
ZCBieSBzYXZpbmcNCj4+IHRoZSBjdXJyZW50IGtwcm9iZSBzdGF0ZSBhbmQgc2V0dGluZyB1cCBz
aW5nbGUtc3RlcCBmb3IgdGhlIG5ldyBwcm9iZSwNCj4+IGp1c3QgbGlrZSByZWVudHJ5IGZyb20g
S1BST0JFX0hJVF9BQ1RJVkUgb3IgS1BST0JFX0hJVF9TU0RPTkUuDQo+Pg0KPj4gVGhlIHRydWx5
IHVucmVjb3ZlcmFibGUgY2FzZSBpcyBoaXR0aW5nIGFub3RoZXIga3Byb2JlIHdoaWxlIGFscmVh
ZHkgaW4NCj4+IEtQUk9CRV9SRUVOVEVSLCBiZWNhdXNlIHRoZSByZWVudHJ5IHNhdmUgYXJlYSBo
YXMgYWxyZWFkeSBiZWVuIGNvbnN1bWVkLg0KPj4NCj4+IE1vdmUgS1BST0JFX0hJVF9TUyB0byB0
aGUgcmVjb3ZlcmFibGUgcmVlbnRyeSBjYXNlcyBhbmQgbGVhdmUNCj4+IEtQUk9CRV9SRUVOVEVS
IGFzIHRoZSB1bnJlY292ZXJhYmxlIG5lc3RlZCByZWVudHJ5IGNhc2UuDQo+Pg0KPj4gVGhpcyBt
aXJyb3JzIHRoZSB4ODYgZml4IGluIGNvbW1pdCA2YTUwMjJhNTZhYzMNCj4+ICgia3Byb2Jlcy94
ODY6IEFsbG93IHRvIGhhbmRsZSByZWVudGVyZWQga3Byb2JlIG9uIHNpbmdsZS1zdGVwcGluZyIp
Lg0KPg0KPiBDYW4geW91IGFsc28gY2hlY2sgdGhlIFNhc2hpa28gY29tbWVudD8NCj4NCj4gaHR0
cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYwNzA2MDgzNjM2LjE1OTg4My0xLWh1cHUl
NDB0cmFuc3Npb24uY29tP3BhcnQ9Mg0KPg0KPiBUaGlzIHNlZW1zIGluZGljYXRpbmcgcG90ZW50
aWFsbHkgYnJha2FnZSBvZiByZWVudGVyIGtwcm9iZXMgb24gYXJtNjQuDQo+IEJ1dCBpcyBpdCBw
b3NzaWJsZSB0byBoaXQgYW5vdGhlciBrcHJvYmUgd2hpbGUgU1Mgb24gYXJtNjQ/IEl0IGlzDQo+
IHRoZSBzYW1lIHF1ZXN0aW9uIGFib3V0IHRoZSBwcmV2aW91cyBvbmUsIGNhbiBOTUkgaGFwcGVu
cyBkdXJpbmcNCj4gdGhlIHNpbmdsZSBzdGVwcGluZz8gKG1heWJlIHllcywgYmVjYXVzZSBpdCBp
cyBub24tbWFza2FibGUpDQoNCkl0IGlzIHBvc3NpYmxlIGFzIHRoaXMgaXMgd2hhdCB3ZSBoaXQu
IFRoZXJlIGFyZQ0KcHJlZW1wdF9lbmFibGUvZGlzYWJsZSgpIGNhbGxzIGR1cmluZyBTUyB3aGlj
aCBjYW4gdHJpZ2dlciBwZXJmIGV2ZW50cw0Kc2FtcGxpbmcgdGhlIHVzZXIgc3RhY2ssIHdoaWNo
IG1heSB0aGVuIHRyaWdnZXIgcGFnZSBmYXVsdHMgYW5kIHNlbmQgdGhlDQpDUFUgaW50byBvbmUg
bW9yZSBsZXZlbCBvZiBleGNlcHRpb24gY29udGV4dC4gSSBiZWxpZXZlIHRoaXMgaXMgd2hhdCB5
b3UNCnNhdyBpbiA2YTUwMjJhNTZhYzM/DQo+IEFueXdheSwgZm9yIG1ha2luZyBpdCBzYWZlciwg
d2UgbmVlZCB0byBhZGQgc2F2ZWRfaXJxZmxhZ3MgdG8gcHJldl9rcHJvYmUuDQoNClllcywgdGhp
cyBzZWVtcyB0byBiZSBhIGxlZ2l0IGJ1ZyB0aGF0IG5lZWRzIHRvIGJlIGZpeGVkLiBUaGFuayB5
b3UuDQoNCj4gVGhhbmsgeW91LA0KPg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFB1IEh1IDxodXB1
QHRyYW5zc2lvbi5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBIb25neWFuIFhpYSA8aG9uZ3lhbi54
aWFAdHJhbnNzaW9uLmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL2FybTY0L2tlcm5lbC9wcm9iZXMv
a3Byb2Jlcy5jIHwgOCArKysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva2VybmVs
L3Byb2Jlcy9rcHJvYmVzLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9wcm9iZXMva3Byb2Jlcy5jDQo+
PiBpbmRleCBlNGQyODUyY2UyZmIuLjc2NGIyMjI4Y2NhMCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gv
YXJtNjQva2VybmVsL3Byb2Jlcy9rcHJvYmVzLmMNCj4+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVs
L3Byb2Jlcy9rcHJvYmVzLmMNCj4+IEBAIC0yNDAsMTAgKzI0MCwxNiBAQCBzdGF0aWMgaW50IF9f
a3Byb2JlcyByZWVudGVyX2twcm9iZShzdHJ1Y3Qga3Byb2JlICpwLA0KPj4gICAgICAgIHN3aXRj
aCAoa2NiLT5rcHJvYmVfc3RhdHVzKSB7DQo+PiAgICAgICAgY2FzZSBLUFJPQkVfSElUX1NTRE9O
RToNCj4+ICAgICAgICBjYXNlIEtQUk9CRV9ISVRfQUNUSVZFOg0KPj4gKyAgICAgY2FzZSBLUFJP
QkVfSElUX1NTOg0KPj4gKyAgICAgICAgICAgICAvKg0KPj4gKyAgICAgICAgICAgICAgKiBBIHBy
b2JlIGNhbiBiZSBoaXQgd2hpbGUgYW5vdGhlciBrcHJvYmUgaXMgcHJlcGFyaW5nIG9yDQo+PiAr
ICAgICAgICAgICAgICAqIGV4ZWN1dGluZyBpdHMgWE9MIHNpbmdsZS1zdGVwIGluc3RydWN0aW9u
LiBUaGlzIGlzIHN0aWxsIGENCj4+ICsgICAgICAgICAgICAgICogcmVjb3ZlcmFibGUgb25lLWxl
dmVsIHJlZW50cnksIHNvIGhhbmRsZSBpdCBpbiB0aGUgc2FtZSB3YXkgYXMNCj4+ICsgICAgICAg
ICAgICAgICogcmVlbnRyeSBmcm9tIEtQUk9CRV9ISVRfQUNUSVZFIG9yIEtQUk9CRV9ISVRfU1NE
T05FLg0KPj4gKyAgICAgICAgICAgICAgKi8NCj4+ICAgICAgICAgICAgICAgIGtwcm9iZXNfaW5j
X25taXNzZWRfY291bnQocCk7DQo+PiAgICAgICAgICAgICAgICBzZXR1cF9zaW5nbGVzdGVwKHAs
IHJlZ3MsIGtjYiwgMSk7DQo+PiAgICAgICAgICAgICAgICBicmVhazsNCj4+IC0gICAgIGNhc2Ug
S1BST0JFX0hJVF9TUzoNCj4+ICAgICAgICBjYXNlIEtQUk9CRV9SRUVOVEVSOg0KPj4gICAgICAg
ICAgICAgICAgcHJfd2FybigiRmFpbGVkIHRvIHJlY292ZXIgZnJvbSByZWVudGVyZWQga3Byb2Jl
cy5cbiIpOw0KPj4gICAgICAgICAgICAgICAgZHVtcF9rcHJvYmUocCk7DQo+PiAtLQ0KPj4gMi40
My4wDQo+Pg0KPg0KPg0KPiAtLQ0KPiBNYXNhbWkgSGlyYW1hdHN1IChHb29nbGUpIDxtaGlyYW1h
dEBrZXJuZWwub3JnPg0KDQo=
