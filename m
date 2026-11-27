Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790192;
	b=YJD+arrS3E5BzselTJrltuRMGp/oIt+8WHwNZr+QaGcXxMrP4rWME1GxuwKc45KTbjhi
	 aj4cZU2IsHQKLWKwWsvyoVDVmyiwieRahE1dQmFVf9nePF0nwLRycdFR9tN7Y3v7SkiED
	 MOvY3bluFsgY+uICLRg9SojX6rEaJJCQyiluL4XAq60y3IOE5rvrx5GncQyqhoUiR1GIN
	 pCGxfZLvNA/63rUUYWnMlhXvCv4PIyn/bDqWMwTnC7kKksy3v+1kZwG+qHpDjpVEMBSko
	 0lAqLdCn7R10xz+/mnGMyH1JSPO00SIXbgigmHkEaSvr0iHwBfffgHSwWF4mnqp79mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790192;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=AHaTSm6CqCBOKkE+cKbRMkVfAAPiwIJkTVx8GjdxHPs=;
	b=xEodoSlQj9gnHvODM4z3Y2L8kExs0L2lcoEkqRWfsnCJ2WaOWnaLtMC2SnXOLFxWWwVz
	 5KrWeYTjlbi2YhLzvocBlXJgroBGgQAUY5NSMn+R57m0QEkvABD19GNvO6Gz/U+QlFRGi
	 RCupc/BqJxmGrz0PN0q8v7uDkx+yqoVKKoeRWUqLZZyE+v+ZsGTQ1rRBtFSrY0foaCCPj
	 bd7cI5aeQM6p+ah1jr8geipu58PZCCYCOTw+Xq5lTwmq7YPHjYZ+9Fqd5W7ugf2bRenDp
	 cJZ7QIIKxrcF76hZgkeaerxC3/NlH01nlvKuNsj3NSyHGy2ruVbw1vyx4B+OHvpGNbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="f+lGq/KT";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD8606A338
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 14:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DD8606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f+lGq/KT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795790191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AHaTSm6CqCBOKkE+cKbRMkVfAAPiwIJkTVx8GjdxHPs=;
	b=f+lGq/KTgJFHp/ihjEJBuiMr9Cuxmph03oK4KYDYY0Gm3lacRjqUOssKqA37dqBtihmzU0
	x5t+3o7ivF0wohoGa0IaeBpvAJlZLuDsphKvbNNmx+xus++eL5hjWOTCJ1m4xwcZCCt+Sa
	N2XBT1eVMAa/I6pqe6K846hyZFMdiV8=
X-MC-Rep: binary re single
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-Tt0Z-WJgMNOn5KTHuk9j6A-1; Fri, 27 Nov 2026 14:36:28 +0000
X-MC-Unique: Tt0Z-WJgMNOn5KTHuk9j6A-1
X-Mimecast-MFC-AGG-ID: Tt0Z-WJgMNOn5KTHuk9j6A_1795790188
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so6732883f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 06:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790187; x=1796394987;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AHaTSm6CqCBOKkE+cKbRMkVfAAPiwIJkTVx8GjdxHPs=;
        b=FA1V9x6PB8rm4vIAZQLKIZxnAfPZnFrIvYSC8TWAQrJolihy9n5SMvm+GXqdgPOpQ6
         Twr6IAJbnt4+2k7svKssT547aCsrP4x22LY15YnSTpZMXCqgKNbjtjiAHZCAaCA2UoFg
         JCQLbtFCiLlOh9ix4JjdaetjvOgtotfb3rtGeROnR9hi/8L9Wo3ZXRT3ME1Bt5nErwLe
         6gB3pOmmvF5dFyM38dbxXDD+QabAr7gCeTalDayJEzgfqcXvDyUCAdDG+RD+4DhihzyH
         x5dRJ8IhzhWYkuxAXYGw2YdNd4/iz/08TqcSwR2H9tskdLFMx28rKLIOWNd50N1DTH6S
         inyg==
X-Forwarded-Encrypted: i=1; AL+hErFhSVlQOXLJXLU4DNumpPts4utNFkPGBAaZNF+WvOlqxAqD2Y6TIaryGt3/t2OVimZqMwtJ1hErGybTlL3te9DM6tA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iub666/XR7nv9ouB2OkV1RiHxonX++CnxcMA3d0fEfSTmkm6w
	fXMrKFAUdgDC51/AGQEetMqFyGhqGob4anz7noxWSMTDJDmdOA8NOa6DixrayMAP4lYdnpNWhYL
	UOylx23g7huFVzUdQtMJsRDITbkI7mhRADS7SKinstu00YI6y9eZX5gZ/kkkSSB9Od1dIFC/+AA
	==
X-Gm-Gg: AZFdTZeqMLzFq/EO7HLCDlJ/5G1hW5OGYl9RerdDmCzT9jzb/nIIS36Dn0Z/DDYojEX
	cD3WyVrcZfLt++oODwsDzydctM7mBnWreiJ7wganFX1ZLHmniHOAzrSVAI7s+TZ8ipWjXVKBB+0
	GU9O8kdVFxcI8hLZTCCzo/ob3eaX1aQvKT8cmA3/ZnF3UkbuH/eCCe3sUtrzmSOlMyTDptlT8h3
	vZeIczYWTqPGS5lsDo4oJccc9EGGk9c3Em8Nv5PG0jRNLrQ2dZWF1vn1wGin7Km7/iiwIX9RMxt
	6LzxMQWBHf4QgIUV6iTYoWOWGdP3XrV/yabQIjm1gnXxaPa08lL2bqSJaDUSqfMV8Md9gR9Ewj4
	5kzD9t4oAfooragbi0/h7vz5myJm3yKj6tb7DbGylVF3XS1vcyBPnKXt/aMNLlznN2LkyV59vPH
	bB
X-Received: by 2002:a5d:64c9:0:b0:491:92e5:b5c2 with SMTP id ffacd0b85a97d-4abb1baaaa5mr50096518f8f.15.1795790187592;
        Fri, 27 Nov 2026 06:36:27 -0800 (PST)
X-Received: by 2002:a5d:64c9:0:b0:491:92e5:b5c2 with SMTP id ffacd0b85a97d-4abb1baaaa5mr50096474f8f.15.1795790187167;
        Fri, 27 Nov 2026 06:36:27 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm48633531f8f.3.2026.11.27.06.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:36:26 -0800 (PST)
Message-ID: <b3aab99c30da8fbfe8d2a7b1bac7795d2e1d04e2.camel@redhat.com>
Subject: Re: [PATCH v5 3/4] rv: collect per-edge dwell time for per-cpu
 DA/HA monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 rpm@xenomai.org, jan.kiszka@siemens.com, Shuah Khan	
 <skhan@linuxfoundation.org>
Date: Fri, 27 Nov 2026 15:36:25 +0100
In-Reply-To: <adebe91c-09cf-40b3-9780-998cea432226@siemens.com>
References: <20261127113609.650286-1-tobias.schaffner@siemens.com>
	 <20261127113609.650286-4-tobias.schaffner@siemens.com>
	 <edac7605937c5fd1a02458e171ddfa4d5e6c1a36.camel@redhat.com>
	 <adebe91c-09cf-40b3-9780-998cea432226@siemens.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
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
X-Mimecast-MFC-PROC-ID: 2BW9k92B9Ot1AAMav4Ke1f3Lmcnstiusnh7AyrjIhto_1795790188
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-27 at 15:13 +0100, Tobias Schaffner wrote:
> On 11/27/26 14:57, Gabriele Monaco wrote:
> > On Fri, 2026-11-27 at 12:36 +0100, Tobias Schaffner wrote:
> > > Hook the edge-stat facility into the DA/HA layer, so that any per-cpu
> > > automaton monitor also reports how long it lingers in each state.
> > >=20
> > > Account a transition as soon as its state change is committed. An HA
> > > constraint that rejects the transition can therefore reset the monito=
r
> > > without leaving an accounting window for nested events.
> > >=20
> > > Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> > > ---
> >=20
> > Looks good to me, thanks!
> > I'm taking the series.
>=20
> Thanks for all the support! I will continue with the missing bits for
> per_task and maybe also per-object and global monitors soon.

Great, thank you for the nice addition.
On the long run we may also want to have this integrated in the rv tool, pe=
rhaps
to do some filtering, aggregation, or pretty-printing.

One thing at a time though ;)

Cheers,
Gabriele
