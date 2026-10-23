Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792766639;
	b=kUgrd8WfnsSnaAGPWDAlnHy6JgnnB/2U/8h5vxXLAVk7spI5+Uhx1aJsCqfuSvWKYzpY
	 0enmi6ck1GmqyqBixseqAIUg7MHr94gouywwyHwucobhm3ln1p5VnrS8Q7C/CXtagzW5u
	 tIrj0FOgzueJ0m08LyJ4Fl9NInOuyVGWHYCTPqg76qmk0kPImepy86UbyIKI1oGWjG+/O
	 2cEpY9/H/L1C8sMQB6jW52pAhavhGQuqgJmNT28yrEMgBfzNqwFPNWNboaXv4t5b31wyW
	 /eQg5NuE0g03UBF2qnWQBra2DdHiOnCXtNCAfLFBn4pXUQO8LEnDYPBOUE2f2ZdeYwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766639;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=erFZ2N8drsgFVvCe7mPMYkub3HB7wc9GLfWe++98/JY=;
	b=tdQDj9X1azPNPyYNe+NkPZqh1c69rvvc7YEAYgcQUMpEfGSU+H4m6rUjJCBDPsat13ZC
	 bUqs+HWWkBbzs96PNYK/IMBqJwzITWcInPEIWD1HQIf5WtLtjcEd5BYrh6UqOgRyNXcbg
	 w2X7FTpKkZY2ssL9EJFAeEbR5jSK5y1QnomA8/h4QSlCaonTp44ySqbqzKlYFw91gzyWw
	 GidCykJ9WrMkCRETuxX23KeQJNPu8EIX6Mrkwi/vfPHM5DAuny3s7frYSrMSGEo6WPvWv
	 jUFFUU1RELuzBJXZBHr9ky6ruiXtPBrUMSC9w7u59rPhrld8KJE3MjFCZdkdr/niQFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NJnbcYpK;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250D606A31A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 14:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9250D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NJnbcYpK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792766637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=erFZ2N8drsgFVvCe7mPMYkub3HB7wc9GLfWe++98/JY=;
	b=NJnbcYpKN2NCsW4I7/dRindoO9uDpKxzi159VtpwhB1z1/15mV0iyTU6Tj9YV/9fNDFn50
	uZ53sqsYfM5K9Y5ebNXOdwhan3/YyWYUd9aF1Yglm4DJ60ARAj18cq1wlTFdKrYBBPnaYl
	jzgV5VhG3HJzlwRgclB771aBkh5B/II=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-aAEXW2W7P6qCz4EZy9l78Q-1; Fri, 23 Oct 2026 10:43:56 -0400
X-MC-Unique: aAEXW2W7P6qCz4EZy9l78Q-1
X-Mimecast-MFC-AGG-ID: aAEXW2W7P6qCz4EZy9l78Q_1792766635
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c25501f4aa2so127039166b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 07:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792766635; x=1793371435;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=erFZ2N8drsgFVvCe7mPMYkub3HB7wc9GLfWe++98/JY=;
        b=zTz+reRAeneNuze5Zr22Ngvo2PdFjcnx/ciWGXQ/05TfvrQ2GRR9C+SLEQoeMu6kWw
         XEIhxxjm3ABhJkGjNa4CXrOB9mxIODHhMmIbLytjXyklwWr7tzVXDf/6h/fJFAWLT2TO
         UqRrKrzjYFwxn44YLnVEkpz6/gaeVcU30TiJZbZ9yuqoL+nalRekCFvuelgDzBRkOdsH
         j2AEM2YlKTAS6m2uA1L+G+U+VL3Id9yTV102Xu5qXmpO09CDEtsGqJJ0LHOpBi3XdV5i
         WxZsBwXrFmdBEQS9iedQAiZcrEhvyF6rvb80Dfcw+7b8NMAsleiE6Uhk226nIET3FfXQ
         p9bg==
X-Forwarded-Encrypted: i=1; AKwUvBxp7xNLwhvYJ7U7xCJQIHp7oX/HqUihdt8IyYnzfff/Z2LNvo9Vn8Jr47XuqRi810/S5uAXRycHK7cuOF5CLYInDnw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLASPbB6hH2EuvyaW+n87ryV9t0oRu76++yofD5NSqGJ8GffZ7b
	U/L+7DzWUwPD/bVCRJ/68j3nU9DYkWwVOIdlPFo4iX4/G/unTWW9cvx8aizw06OuYVZWN3BAOXU
	wBhyFAOVswmKiBVfshVP2g4ROQ2b8ExBd79g75gm0pa6TxdJ1fHRhNesDw6UlN5VdZZ+bXzK5qw
	==
X-Gm-Gg: AYBFou1z/fSfP+vIjUlYfbFuMMZpCXjGXE48LUdQcE3T49lr2JuC6i/VvpCFh5RC2sg
	kSkySZfQK1VF3nSohqzjIuGj4AZ40kzvxUesAtoRZz2VNOINXnN0M/9UWLM3CqR3BMnePpNXhj3
	37cfX4DLi/5kYwa40HMQH/hNoEF7XVknMr1BvA8H23kt43yxGvkJnuiAkO4bBAXRCUu6lQktYPT
	U+ypJzq8GQ1TzoWA1hIGrj63eqt+wpx2sksVdGPGX7oxQdl87osgp9M1nZlakxHpYmZ4cgWnVki
	zmNrWZk5HHde3xFIMlKSVIQMVSz/6B26FGxviXuZ4aHuD9z1FfIDo0g6f8MSMman0rwX2EOFaCp
	DdoHkSjuBSlBKA6tAUSusDWttmk6s
X-Received: by 2002:a17:907:d22:b0:c26:1cfd:4244 with SMTP id a640c23a62f3a-c468d794de5mr821386566b.11.1792766634991;
        Fri, 23 Oct 2026 07:43:54 -0700 (PDT)
X-Received: by 2002:a17:907:d22:b0:c26:1cfd:4244 with SMTP id a640c23a62f3a-c468d794de5mr821383666b.11.1792766634546;
        Fri, 23 Oct 2026 07:43:54 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b432b4eeb2sm1233445a12.0.2026.10.23.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:43:54 -0700 (PDT)
Message-ID: <19beabe52e6d6c6c98e3ce6ae89867356e18b2fb.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
  Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Wen Yang
	 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Viktor Malik <vmalik@redhat.com>
Date: Fri, 23 Oct 2026 16:43:51 +0200
In-Reply-To: <871p9ita52.fsf@yellow.woof>
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
	 <871p9ita52.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: E86wrEsw4YuYnOGk97G6OlUGY8Ry3peJLVWscLDsf_k_1792766635
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-10-22 at 10:25 +0200, Nam Cao wrote:
> What about we refactor the in-kernel monitors' trace events into a
> single one. I am picturing two functions for ALL classes and ALL
> monitors:
>=20
> =C2=A0=C2=A0=C2=A0 void rv_error(const char *monitor_name, const char *me=
ssage);
> =C2=A0=C2=A0=C2=A0 void rv_event(const char *monitor_name, const char *me=
ssage);
>=20
> which trigger the tracepoints. And we make those kfuncs. This allows
> sharing trace events between in-kernel monitors and BPF monitors.
>=20
> Then everything else (kernel reactors, users, perhaps even eBPF reactors
> in the future) hook into those tracepoints.

That could work, though we'd lose some ergonomics around filtering events, =
not
so much in the unified tracepoint thing but in what fields events have. We =
would
need to parse a string (so I wonder if globs can express constraints like
matching whole words or we'd need to arrange the format to accommodate glob
limitations).

On the other hand if we still want to keep fields, we are going to need
event/error pairs for both DA and LTL and a way to match monitors with thei=
r
class (needed if you want to surgically enable the right events for your
monitors).

Both can work and what you propose is clearly simpler to implement, I can h=
ave a
look.

Thanks,
Gabriele

