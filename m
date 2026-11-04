Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793832123;
	b=LV7FQrj6tyLN+FkFDkplbYub5rLpeoep8is/INw4KBgYiTstMLfiFlvIoAaD3VXjTFyh
	 5baoHDM0/bfVwuRqx0jlkJYopufSW5p7X2VIXAKAC+cQFT9DW7QeNPCTrT551reFRjdiI
	 yB66RefAkYHtZUpaotehgjHQkw+Kcw8FktHAiFJor92YU3j/6EWkEGvbW26+oMHrQjTwd
	 5JLxdPOezSGjuHyVI4frOLdG0PUQGZ0Nzzdh/Y9w4N3wFV8uRc19qlJv3DxlfimclY8W3
	 EIN7Kdwmjrk8I5YZL69N499LdkKLiiwRC3bWQhoy1671Y3S9P7Dkna5GQknDUg1p3aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:X-Mailer:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=WErvo2GLUvNSKhdIQULmZWHJk9AdernDD4tBPDZdzN0=;
	b=j6g6Xhrx91X7C18zcKmmo1QPN/Y/+qpnv/eU4dLg25ob9vOA9Rrq1NGA7mJsXIECEFgD
	 HI/nBvBE7taqst2/hET/5ZGl4Uh451l+Q9jb+0CLCdElzVydhfkQVGrI/8D3f89u1d/Zf
	 Oa0ajDIns0U4LPQ5VqiKWoGDXLHputR//dhBa8vNdt2LAG85HXcAMNuMBeuiAr3Rxcz/s
	 +BuwdyWt739UXi703uk8W1yH9h3ATT9rx4aQClomDK/dL2xVckaO39iLBuqa8KnfC2Nz8
	 gY1jUoxy21modY9tRFYuhDEuXAMwhnfMl5Ak6pwKB2k7P0kXn2rCo9s0OwLaASMus8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q6L7IR3F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA580606A332
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 22:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA580606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q6L7IR3F
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-5058b105df7so494905b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Nov 2026 14:42:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793832122; cv=none;
        d=google.com; s=arc-20260327;
        b=FASKBYVdJlLo+rZemzFzl0QwqsHa34945sw0KYFnHEOeVlVoAOdNPFPYczcfHRW7yF
         YKaEh5WgcNc7mzK/AGNg2OEuSZwwvUIubp5tnFIWJ15dmUlLLYzlEWrRpwFaky5i6lMN
         CK3cLGp8PTdgRl5DJOZ+D17dSE9pitxtK7y8m848t6GG6Rcc14ucC+X/zLVxs6Qj4hZL
         j1uMK6555lVpEkc//ToqyBmVxvmh/ozSeJ+Yw3SQDe5ORjRNliqjj93dffUCGUGIuWY/
         0ypxUyh6R4oFc8vycW68rnh1bk/22XbtQelQBMe/49LJJeLABOM5UGgIbgQ3xpIE4vTr
         duDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=WErvo2GLUvNSKhdIQULmZWHJk9AdernDD4tBPDZdzN0=;
        fh=08wX0+2Bxr3s67vMHsosfyjl/BbdRffukLAFSth2440=;
        b=fiODPWhHleWrI8i+zsgfqD6fBT7CcN+9P3nrdstzZp2i6ZKu/aeL2uYatQj1db2Q5j
         6Mp0/D45HpbbOPlz6jvSJS62p0P13DQUtboo93to9vHF7VpA4iAF6f6Fenvzmn4zr284
         a8swWoeGoKnJCE1mnbIR2gk0IQo04EsKp+HpEQxDpVMaka+Uy7sHZrrXeLL8tmFI8gZy
         GeKI/ULuhjZLBgv5EssGYfv9bxd9/+pru96ld8dD4IDFGYvsabqyYgYMKYP2d4+/uBOe
         kK0+ZqaUnd3BzOvQ1jE7vVrHLZRysQmas6wL0X2ugzgLOwkvj2PXCM9B6mRU8cuKvb4p
         75lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793832122; x=1794436922; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WErvo2GLUvNSKhdIQULmZWHJk9AdernDD4tBPDZdzN0=;
        b=q6L7IR3FtwIQ0LkPfu40pZoBfPvKqcXL94JSwnjEeU1VRPv45r41nGikNoRjoE6Lz8
         77lQlxZW89Vo7SeWgBTaBEMaMOpRPEIATBduFwLR5eivyQhkLKMb7ebKSylU/zcxAMAn
         QdEQ1u6CmPjFSsiYNaj4KC5t6jTNNT41P6amusS7ikGkxTAkfqgufR9YwGD5n/NsdoS2
         aNTAeeAbvMxzklhxrj9gajGaAY5XC7gbB7a1tPPoXeL9/8A1O9dsLuQHtiIWbSES0Nec
         3mRKNkaJOnRlXQZjcd5BviFWfwnRY3UO1KxvuyTl+O5RHhZndfBroxLdbHo7DdVYrqpC
         C+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832122; x=1794436922;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WErvo2GLUvNSKhdIQULmZWHJk9AdernDD4tBPDZdzN0=;
        b=mp/UriH05FaxWOb/7/j36ujNZQGf6b0VKz6AS5V/i5B7fSyLbH150wqCIgxBYP3ElX
         dTJJI6Qff6CzwOzbtYygRAq3KLVTD8dmPPzxqkv87qkWmDEsCkdXZCPn+IuZFDTn7kWH
         cIHQNLkbMEvsowbu9xy+F1su9UcI1AII4zICtWUMshb2fiKgNg+ShKjuxz2OTkqyJcMh
         gv5oRC/SO79fQaH25rKH6vF96/Oxa0Q6ka2mR8rbxFb1gwVa9dzTQHLNtPge5Mcj6Ni1
         4A/CZDtSTsUtgZ5kVb+sMP+jSmT93YoGFBPL7th3r3RT5KpMolyak8hZULoxTWCZaeso
         4YRw==
X-Forwarded-Encrypted: i=1; AKwUvBzV1cXG6hGlMqfDjsflZ8Lq5XDeVWISG+/fg+IH7wDhAAaC3/vAa1G8V6DNWOK2JjaKzFEuVKqmbyDORvqhxEdQIqo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bcvEE4JomefYbHIggzUI4RhkxGtl4UUIUilJ27PCerc5CAWly
	3l244ZISPYbLEIFDW1+9GQzM6f/CvWm994DSsVOWfmmMYmZKGU4Iq3dkolhjEDU6pcSm/Ul3D+5
	vsJyumNsKFIIWruIZ46bG7PfJf+XBPgNXGdQ/eO0=
X-Gm-Gg: AYBFou2If6YKspiyxj3MmtJXT+BwcWPcIvITqh3QpOsCwjQz/e/V6TQraZOFKSCRvRW
	I5/wF/zgfDRhf4JIJJR6G20n9pQ9g/v4tlWuqmbdLRSQuj8OGcKLWdxnA6/tlSzNbFzwgxJjtEn
	hD6uiEBaxHjjgVVGZTSH9PjjVACA55Ig8jBsVWAlrpAFedJwbR6Eoal1Y07qdp+evldaK81CmgM
	WsQ8a1361/IemWdsrhORM53hxs5JVrv8nJWkiO9j2l9IR8g5lhH0/QbMR5/10ufWiTzKINFFO6t
	Zvpob/+GqShumE63k/dQuxqZpUN3hshDUpoL581iWQTr9XlXNvH6NGDf/SD54zCsEx8RrjF4ydd
	0GIPRcUsJ/wQZ4Ge95LBF5j0HETj7yjg06TDY5xi3tBUCq5uqe+pZ+vy0UGMiLC1lyvbFog4=
X-Received: by 2002:a05:6808:11c7:b0:539:dfe8:9960 with SMTP id
 5614622812f47-5640de0f2bamr12348302b6e.56.1793832121760; Wed, 04 Nov 2026
 14:42:01 -0800 (PST)
Received: from 41474967715 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 4 Nov 2026 14:42:00 -0800
Received: from 41474967715 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 4 Nov 2026 14:42:00 -0800
From: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <CADZg-m04iG5kCZ5-yh=Vz_ysYjVDGSYn3je4_-8AzWWfiC-bXQ@mail.gmail.com>
References: <CADZg-m04iG5kCZ5-yh=Vz_ysYjVDGSYn3je4_-8AzWWfiC-bXQ@mail.gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 4 Nov 2026 14:42:00 -0800
X-Gm-Features: AclHuK8VXrXubivnKeWdOi0BsvXqCf5pOWGutxidKBItsHpI5FtVw2Y7RLuRbVQ
Message-ID: <CADZg-m0FeLntAS6XxE-kc74vwH-jAh+jXT68qnVwXuHZNUHzfA@mail.gmail.com>
Subject: [PATCH v2] ring-buffer: Skip time delta validation for the counter clock
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

The counter trace clock increments on every read. Time delta validation
assumes that the clock values read while reserving and checking an event
can be reconciled with the deltas stored in the page. With the counter
clock, this assumption can fail for an intact ring buffer and report a
spurious TIME DOES NOT MATCH warning.

Skip time delta validation while the buffer uses trace_clock_counter().
Clock selection already resets the buffer, so events recorded under a
previous clock are not retained for this check. Recording and reading
counter-clock events are unchanged.

Link: https://lists.openwall.net/linux-kernel/2026/09/20/1283
Reported-by: syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=eb74dca0d1eb3ec227a7
Signed-off-by: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
---
Changes in v2:
- Resend as plain text after the previous mail client reformatted the diff.

 kernel/trace/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a7..c860d5b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4747,6 +4747,10 @@ static void check_buffer(struct
ring_buffer_per_cpu *cpu_buffer,
 	bool full = false;
 	int ret;

+	/* The counter clock advances on every read, invalidating this check. */
+	if (cpu_buffer->buffer->clock == trace_clock_counter)
+		return;
+
 	dpage = info->tail_page->page;

 	if (tail == CHECK_FULL_PAGE) {

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
