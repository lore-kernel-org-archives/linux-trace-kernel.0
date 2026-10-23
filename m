Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771996;
	b=t4beNV9cJ+N2IJ1t8sggBKNX2NeVRyoCbyNlgNwhhqJcgifT0IZQj3kUQB9mNd2jWwKr
	 D2UyKJJlg+wRf71XgltIAS08RPQPhCPfe54xqxdmDwk1fuZMWS/fMd4cKa1OuTjwn4JdG
	 IYypMxg1LGA2x3wcq6YtFSUGxkma21pahUFSj3D2cpXrD8rANzZzefyQdSOTl6KjQdsey
	 wgkhXUJ/+ErMXXdBkUqBLvSI4LTjfMloGQ71wH2oOq+y80/AG8XhJJA8943shu9dqRkG2
	 MTsxWsIq3yO8lSCQs3HnVjHF8H7nRY/KY+pm4UxEt943xRUNLIeaiOq5wyVrMWbJkUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771996;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=3ksVuDUqMf/kfLTk7MjjHXeosYCMKCsBfhfswI5h2f0=;
	b=yTQwHM/yzByofF1FOiVPVvVhJf8d/gG5drK78PZ1GPyZB83FPbJDxMUntDueY+R2yRPE
	 Yid4Ik6sjOUSaqcyHLHvbgC9qsIHiNLkZDtX4xWmlZ1Rg6G6kGlhXRRltnAgAftFJ5dkV
	 tRqs1jqpM/EisyChth5TWpNWqPyjAQ76Hd6OUk57gl6s5kYILsWI6Z0utupDmCw9XFuV/
	 L4FDmJMGdUcWdIvCv8nWYOzamEbfR8scwj9SOgm912iau7E08MB9rz6VAEX4mkIIPjq9W
	 wnPfhAcOFE7QdU6RPysil251JAMqEpWCossd/eiTXHa+fpu1/qGVX4T6bOyg/TNqEkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TI5nCU3z;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC4606A31B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 16:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09AC4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TI5nCU3z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792771995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3ksVuDUqMf/kfLTk7MjjHXeosYCMKCsBfhfswI5h2f0=;
	b=TI5nCU3zwGltLYkkVXScGKsEr5WkfI3WhnT9wcU1T1qE8h0WAAH+wHSMWB/2HxbIjYdXI5
	j5r8CEhVUkyTSYzoT3sET5/TQfPuCRyUE+1TvhAfgMlew9CWtKdxf5vZ188LD0D2z0lTH+
	kBa/dmMnsBWyh0Oh0sSodIAu/Q9sLn0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-6yelu-seO0GQvRjjZPdgTw-1; Fri, 23 Oct 2026 12:13:13 -0400
X-MC-Unique: 6yelu-seO0GQvRjjZPdgTw-1
X-Mimecast-MFC-AGG-ID: 6yelu-seO0GQvRjjZPdgTw_1792771992
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a01d1fb07bso12677635e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 09:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771992; x=1793376792;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3ksVuDUqMf/kfLTk7MjjHXeosYCMKCsBfhfswI5h2f0=;
        b=CTuzLzHdDQ3OLxQYBFEb1kRH3YNmYTT/pJ2hX79ipEc4p/yaM3JbI3ojWcNy6Htn6M
         D9Psb3XGuflTvW4ky3kxBZdq5utBVJWa8ebyBaxOMRkXhFZApBWXCB0klBi9YtsQpobY
         fAmAyRuYbwRoG8Krn7nMsVeqXRztqjn8eJFSRHBse/TQ5MVzAQESIuDWHDbAEa5uYXv3
         3mPCoVSfMCZbj9QVc3Pse1U6fXTXityYyKJk7cKXIBAtbppmsKBFvWCvq6gcQaqf+dfS
         y80/5WdlOfLLc+tYMZY72C9Fd0OXMmOBvuftUotGnc0SSewiFpEJo77KEJBFqAUfHDOG
         0JWg==
X-Forwarded-Encrypted: i=1; AKwUvByZRCOlFyn3rqZe3tVkogFdSTMKObHor1tmZdAsSgMKHWYrVa0BQCSeAUEC1VZcb7u01uRIlIjzrnmws3osKv8pKP4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJ2zCb5rQ0g22Nm8gpcG9Oa9QXa3T0d72BimRKY4FvUktFzFFD
	UTAffATmKa/FeOjFTTCgtrNDg8oVRJ/XEmf/RS+NgWY7u1iz/WsI89l++Zh4RpAa5EYQIPUZ8DV
	FngJLuYVFeK1pP5IuQcPvWJVKLTarskaycE9Rii5jLdt7hVrJWrz7pocEg8N92i2DDzTA+HCXCQ
	==
X-Gm-Gg: AYBFou3DrzQJ5E6V78E+Ebg8J1ets52g5/BFPhubBK0RMiLZxjG9IsByUXSu9+ObGRO
	RW2niiaWkOq19LBwGrtsYtGNh0l7QIColuNeTO+MYyl7SCnHaw5LHP5dEoMsBeNxf3DRVPiN2Zl
	CMPuYTmLL6b8VU4hF8A0Y4yhLsIAFRbwE3WVu5RTqDm0jGxjEJ8/IMaohNGo012kz7cfbqCSHD4
	iB1MmSJ9bv+pR4/8ta6ZfHL3J12hdeJ/2QvNWAWj+JPor5674kjipefG3HPb9XqPxqYrMptjSgW
	zmHFE8A5/GlCKCOFbNC+K3SXztOx1vAimXX8lrZotHaA+3arjoIZnhBla/GklTo4VZNWYIrYiEp
	oAoKS4/BCb2wC6FN6v5fu30JJn19U
X-Received: by 2002:a05:600c:441a:b0:4a1:dfd4:9430 with SMTP id 5b1f17b1804b1-4a211eebdf6mr31752835e9.28.1792771992094;
        Fri, 23 Oct 2026 09:13:12 -0700 (PDT)
X-Received: by 2002:a05:600c:441a:b0:4a1:dfd4:9430 with SMTP id 5b1f17b1804b1-4a211eebdf6mr31752395e9.28.1792771991554;
        Fri, 23 Oct 2026 09:13:11 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d3f0b8asm757666f8f.11.2026.10.23.09.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:13:11 -0700 (PDT)
Message-ID: <3a740fe36bddc50d43be80a0163e5faa0bd96d2c.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
  Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Wen Yang
	 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Viktor Malik <vmalik@redhat.com>
Date: Fri, 23 Oct 2026 18:13:09 +0200
In-Reply-To: <87fqxwv4w3.fsf@yellow.woof>
References: <20261001152042.124445-1-gmonaco@redhat.com>
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
	 <19beabe52e6d6c6c98e3ce6ae89867356e18b2fb.camel@redhat.com>
	 <87fqxwv4w3.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: fsLz9XogqGzxDK_MiJez7EGJHwSpdXkf3T7Pdldksw0_1792771992
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-10-23 at 17:00 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > That could work, though we'd lose some ergonomics around filtering even=
ts,
> > not
> > so much in the unified tracepoint thing but in what fields events have.=
 We
> > would
> > need to parse a string (so I wonder if globs can express constraints li=
ke
> > matching whole words or we'd need to arrange the format to accommodate =
glob
> > limitations).
>=20
> Yes. But the transition event thingy (not sure what we are naming that)
> is only for debugging RV, and the error event should not appear
> often. So I think some parsing overhead is not much of an issue.

It isn't quite the performance overhead, it's that instead of doing

  --filter 'current =3D=3D "foo" && event =3D=3D "bar"'

I'm going to need to do something like

  --filter 'current ~ "* foo x*" && event ~ "*x bar ->*"'

So you need to remember the format.
You wouldn't need to do that if you know you don't have overlapping names
though.

It isn't a big issue most of the time, but less ergonomic for us.
As John said, debugging models is still a use case. LTL puts some gibberish=
 in
these events but they are useful for DA.

But probably the simplified code all around is worth this mild complication=
.
Anyway I'd rather try this first for BPF and then introduce it for in-kerne=
l
ones.
Deprecating per-monitor tracepoints is yet another large change I'd rather =
keep
in a separate series.

Thanks,
Gabriele

