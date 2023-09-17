Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9B8CD37B4
	for <linux-trace-kernel@archiver.kernel.org>; Sun, 17 Sep 2023 21:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjIQVKD (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 17 Sep 2023 17:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbjIQVJo (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:09:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F11F131
        for <linux-trace-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:09:35 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-56-EjQqs1KDO1SKbNzlqdoayA-1; Sun, 17 Sep 2023 22:09:22 +0100
X-MC-Unique: EjQqs1KDO1SKbNzlqdoayA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Sep
 2023 22:09:13 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Sep 2023 22:09:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J0Nsw6ltZW50IEzDqWdlcic=?= <cleger@rivosinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>
CC:     Beau Belgrave <beaub@linux.microsoft.com>
Subject: RE: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
Thread-Topic: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
Thread-Index: AQHZ5w0MDnN0cghZkEiZGsVL8YI6drAfhwPQ
Date:   Sun, 17 Sep 2023 21:09:13 +0000
Message-ID: <94183afa1fca44d18459da3d12a155d3@AcuMS.aculab.com>
References: <20230914131102.179100-1-cleger@rivosinc.com>
In-Reply-To: <20230914131102.179100-1-cleger@rivosinc.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

RnJvbTogQ2zDqW1lbnQgTMOpZ2VyDQo+IFNlbnQ6IDE0IFNlcHRlbWJlciAyMDIzIDE0OjExDQo+
IA0KPiBlbmFibGVyLT51YWRkciBjYW4gYmUgYWxpZ25lZCBvbiAzMiBvciA2NCBiaXRzLiBJZiBh
bGlnbmVkIG9uIDMyIGJpdHMsDQo+IHRoaXMgd2lsbCByZXN1bHQgaW4gYSBtaXNhbGlnbmVkIGFj
Y2VzcyBvbiA2NCBiaXRzIGFyY2hpdGVjdHVyZXMgc2luY2UNCj4gc2V0X2JpdCgpL2NsZWFyX2Jp
dCgpIGFyZSBleHBlY3RpbmcgYW4gdW5zaWduZWQgbG9uZyAoYWxpZ25lZCkgcG9pbnRlci4NCj4g
T24gYXJjaGl0ZWN0dXJlIHRoYXQgZG8gbm90IHN1cHBvcnQgbWlzYWxpZ25lZCBhY2Nlc3MsIHRo
aXMgd2lsbCBjcmFzaA0KPiB0aGUga2VybmVsLiBBbGlnbiB1YWRkciBvbiB1bnNpZ25lZCBsb25n
IHNpemUgdG8gYXZvaWQgc3VjaCBiZWhhdmlvci4NCj4gVGhpcyBidWcgd2FzIGZvdW5kIHdoaWxl
IHJ1bm5pbmcga3NlbGZ0ZXN0cyBvbiBSSVNDLVYuDQoNCllvdSBkb24ndCB3YW50IHRvIGRvIGl0
IG9uIHg4Ni02NCBlaXRoZXIuDQpBIGxvY2tlZCBhY2Nlc3NlcyB0aGF0IGNyb3NzZXMgYSBjYWNo
ZSBsaW5lIGJvdW5kYXJ5IGlzIGhvcnJpZC4NClNvIGhvcnJpZCB0aGF0IHJlY2VudCBjcHUncyBj
YW4gYmUgbWFkZSB0byBmYXVsdC4NCg0KSSdkIGFsc28gZG91YnQgdGhhdCBvdGhlciBjcHUgdGhh
dCBjYW4gZG8gbWlzYWxpZ25lZCB0cmFuc2ZlcnMNCmNhbiBldmVuIGRvIGxvY2tlZCBvbmVzLg0K
DQpGb3IgeDg2IChhbmQgTEUpIHRoZSBsb25nW10gYml0bWFwIGNhbiBiZSB0cmVhdGVkIGFzIGNo
YXJbXQ0KYXZvaWRpbmcgYWxsIHRoZSBwcm9ibGVtcy4NCg0KUGVyaGFwcyB0aGVyZSBvdWdodCB0
byBiZSBiaXQgYSBiaXQtYXJyYXkgYmFzZWQgb24gY2hhcltdDQoobm90IGxvbmdbXSkgdGhhdCB3
b3VsZCBiZSBlbmRpYW5uZXNzIGluZGVwZW5kZW50IGFuZA0KdXNlIGJ5dGUtc2l6ZWQgYXRvbWlj
cy4NCihJSVJDIHRoYXQgaXMgc3RpbGwgYW4gaXNzdWUgb24gc3BhcmMzMi4uLikNCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

