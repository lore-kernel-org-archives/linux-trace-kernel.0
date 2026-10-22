Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668867;
	b=Jai5oMaFTYBERtzvFVXH5S/0b/gqtI6zk1uMM074c5BonRyp6vQfdR5iPQDzUVCp6aIb
	 cq3pPmaNA00hU8+MRLCce+0xeKfuQTofu5130tW2+rOgz2L7DkL+vmw//IKJGgaqn/Dfr
	 rnAOpCFYttZFGmB90vjfMXeOASMiV/+9R5C0TOU5P6Uc0Q2QGUZ8l0vF88us5t2YCaJCl
	 Sbn0rTxXwgwL0JP/3iZKkXlaWHqWcrNCWqD4L3OMPJNAOKf1sq9vpz6wBUemhp2XIwilO
	 Tz5qt62wyYbb/de48NO00EsgtCz7/s5D8j3ZNhPZOm1ROe5SQZ/oncbgufLK6Y8tKvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668867;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=lMj2kvVg1lQ863+tJTpQ87BpPz8MFNV5FHGdt2SXwU0=;
	b=OKVdetZgdvdjkh63hfLNHMZxJOqMlHNya/J04f5C1lK1UAzzUcWJet2EFFhB7HDbr7Ql
	 jWMaG7/1MRyQqG/uotOVBHbkm/c3eywLZ87WZbVSbYBh0+bTDb/5r3p3uXZFWJWb57bEv
	 dvkBfmId6/+nK3lIvD2Ma81urouSlRS1Jxd605O6UyZ0W955ynqOC0iyARQgGu0kyYKR1
	 Bnvzl5m44tivElhiKiuNT1B8z0gr4e0qaFHJ6dBsxvbRAD3zQNWh131Orpu1p69qSdXwM
	 2I1rbsrah6GM4dSSD3DefYyzLDxzLr5sKg3mwj0PY7q/LNl955Gz8UVdkHhAktmFPBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="S/OKfP3U";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967A606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 11:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4967A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S/OKfP3U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792668866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lMj2kvVg1lQ863+tJTpQ87BpPz8MFNV5FHGdt2SXwU0=;
	b=S/OKfP3UR/gY/BdPLtCG9urH4FJuryVhlHj6fnfGuGKB9MbAKvljv/X7Rpv0EmmBiXRzAX
	s4SRDzseParo01f5A5UAEainIu8qAa8DZUgwlS9HP1FLVXZbTnWyDtuNN0768QSCn5C3oi
	fEJyiEGAcPyW6YqEkSYSsDxw52t3LuE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-OOwFVxBzMEyW9K-P2aeg5w-1; Thu, 22 Oct 2026 07:34:23 -0400
X-MC-Unique: OOwFVxBzMEyW9K-P2aeg5w-1
X-Mimecast-MFC-AGG-ID: OOwFVxBzMEyW9K-P2aeg5w_1792668862
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dff112181so1523979f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 04:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792668862; x=1793273662;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lMj2kvVg1lQ863+tJTpQ87BpPz8MFNV5FHGdt2SXwU0=;
        b=rHA7cjcJUK0oAWuepzQoIWBtUfTae2HAXFIhiB+Yps5+Ui5+Ww1rA3OyiUrwsA+1yv
         mAEl2Q432pynMU8wZSmkLgUH9iBT2XlIU+yTLXMY49bGC0p56TSCt8kbZ2zl4W+5K7Ds
         /21cbXuz0v2zTSHWIhYGYO6F/dFBVUMRdj8dSRd8uiRFTIsdL64dgH1qYaFSQ1B6W4hp
         51SnQluij5VzsjZ7veiV1PRwCJ3R5oYdWL3J4kkC4rDPLhOUWTyyol7dIDRwTwgpF5ce
         /yVurPXLQlfpZVReAeiwKaVzRAt+lrgR6AfE0a+DPKAoKUuyQAQNZCTI2SwP8inVRU5T
         /2iA==
X-Forwarded-Encrypted: i=1; AKwUvBzSAn713l9czRjqHTZfAtkgMJZ3wEmqH8TDY+l/VXpIvy5DRF9HLz0Q2LiktU6i+Df62nEyoFUA53LCjRPfk4S47MI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpm5yDLZjKNIfFsHrdaawPmqYOqD54k+eRbGgwTSGKRYhyt3mY
	q+4azqyskZYyh7Z7wwcd6J23m78aler5IRi+vTgPyVVgzIklhVtJI69nnAC6vR8ZLW5d+GQto6t
	uDVeWykc5xhav3G00W/hrrkEQM5q1is83Rvy/+LGaZY/n14i+ystHrUXtPZjytbJokJYXcjpb0A
	==
X-Gm-Gg: AYBFou2Y8UI7gc+n4pxqrL31yG+NANO+lseFDU0Ev0zN3jsvpLm2n7DsMmpXuTeuJZh
	nKV7tDFO7TW06v/4VuYn6PVXIZD6G2eGYTdNFOa75N+be8uWuKgER2CpuPhh+Ev+bWaYOIhM204
	NPQgfu+8NcVIpMEqF/V6HjQsH0OqpK7aXjsnQWzO9Haf4BUrCtnkk6dCaPO9AiaknY1NFN2HAC8
	kAZaErr7aA+okbVIcIP2DHFH2Rfj7FRrXhKyE0zGsOUOPvrHusiQSYVVfxPTXtcUoY/MqQ5Pfo+
	E4E2tKcl1LbWH4U9XmYssgV6QmgouJqA59OnH05jCJHHwMV7kzhQ+nLPw7HLUTGCfMGe5O/Xcuy
	+qBN6v1/fDO2HEYKr7nZ+GVTAzBnW
X-Received: by 2002:a05:6000:1606:b0:48a:f404:6960 with SMTP id ffacd0b85a97d-48e264a38a1mr7689372f8f.9.1792668861901;
        Thu, 22 Oct 2026 04:34:21 -0700 (PDT)
X-Received: by 2002:a05:6000:1606:b0:48a:f404:6960 with SMTP id ffacd0b85a97d-48e264a38a1mr7689341f8f.9.1792668861445;
        Thu, 22 Oct 2026 04:34:21 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2584afe1sm13501902f8f.56.2026.10.22.04.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:34:20 -0700 (PDT)
Message-ID: <382ed6c3bf6ab5f2c31ab9c9becae1b4f53c15de.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wen Yang <wen.yang@linux.dev>, Tobias Schaffner	
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Thu, 22 Oct 2026 13:34:18 +0200
In-Reply-To: <e778bbd7d5e2d2fc07ee365f37db59af04d9a36f.camel@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
		 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
		 <878q3xtptq.fsf@jogness.linutronix.de>
		 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
		 <87bj8s8ih9.fsf@jogness.linutronix.de>
		 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
		 <87v770uuyr.fsf@jogness.linutronix.de>
		 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
		 <87ik2zryzo.fsf@jogness.linutronix.de>
		 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
		 <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
		 <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
		 <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
		 <87pkx5q1w4.fsf@jogness.linutronix.de>
		 <0d4f11b1999588ddba9d855db43fc492eda32de1.camel@redhat.com>
		 <87h5ifqy6w.fsf@yellow.woof>
		 <a8d8b080f403eed617242a3276717706b4081ed1.camel@redhat.com>
		 <20261021094853.29b9f7be@gandalf.local.home>
		 <fb5c20f226f723cbb4df5092462dfcf5f2686367.camel@redhat.com>
		 <87h5ifvw3p.fsf@jogness.linutronix.de>
		 <f147fa9dfc553767ce92802b66723a85cf804e46.camel@redhat.com>
		 <874ieetakx.fsf@jogness.linutronix.de>
	 <e778bbd7d5e2d2fc07ee365f37db59af04d9a36f.camel@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BHmeQc7iwuHo35c34K2F7WSHA5Gz2i-BmY4FIYMi9hY_1792668862
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-10-22 at 12:09 +0200, Gabriele Monaco wrote:
> Exporting all handlers functions is probably going to require a significa=
nt
> redesign of the current RV internals.
> Handlers have access to the monitor headers (everything is static/inlined=
),
> kfuncs wouldn't.

I gave it some more thought, while you could generalise the DA monitor
definition structure (imposing size limits and taking up that space anyway =
or
doing some /smart/ things the BPF verifier probably wouldn't enjoy) then pa=
ss
that to the handlers, I cannot think how to have a kfunc call the LTL funct=
ions
defined in BPF. You'd probably need a helper macro that is essentially doin=
g
what the "shared" functions do now.

I could fire up an LLM and get some /original/ ways to work around that, bu=
t all
I can think of is essentially rewriting RV from scratch.

Again, the easiest thing to do is kfunc only what goes out (tracepoints and
eventually reactors) and keep the rest in BPF.

Gabriele

