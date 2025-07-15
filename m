Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419661E5018
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593062; cv=none; b=bY2W03Oew9Qxzk/R6bWVoea3RiiIPeHNoefSq6Piuoz9R81gem6crfPbr1DiRyoCXhtzb+G/pyQ4a9HvNh/Byh1HNte39ne6RbO8E6ij1Hy2t73uDNCjWQR8AJ3GPFWkLVXrP7/FqUNR1AoGFujOhWssGH0GzouQHUqLSZJlpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593062; c=relaxed/simple;
	bh=fV5l20kDmw5Fm2YqM7yjy2FD9l2J/MsSO1dbCnmVc08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umoM66joi5ACPz89lUQpXB46gWXHKhlvWxCqncEenPT8frLxQIEqpF81+323bIUIk3tj18cTuDAV6gvbTP/+LJNZUgUla1ufNTWM0D8o//JtVXQuwRF8WPhw7A5kLgGWCVxlG9X33JQ9XCfYEsj7qIA/JipUXDHS7RVitXwmZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifSkef0O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifSkef0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752593059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fV5l20kDmw5Fm2YqM7yjy2FD9l2J/MsSO1dbCnmVc08=;
	b=ifSkef0OyQZroIGftTjIFB7T/TR5Joc2Tm8ZEOMMcudUHwER2WKQlcR/eXhhM+Jik2D7CC
	SnwhQIm3H4146r77Iee5pjZTrJn8ttf6xbzmEmPYye9/XdB5Yl4IZiThyY/9NRxs7y41kZ
	5qyuiFxmKdQ3aeDkTVsNtXr4vIO9rGo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-CM1zHj2UNI2UIXCYhHOH2Q-1; Tue, 15 Jul 2025 11:24:16 -0400
X-MC-Unique: CM1zHj2UNI2UIXCYhHOH2Q-1
X-Mimecast-MFC-AGG-ID: CM1zHj2UNI2UIXCYhHOH2Q_1752593055
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so2763072f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593055; x=1753197855;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQXH91nErjb8qEpTCbnLQFKGPXnH6O5DS1xuVtrdrCs=;
        b=mQKk4Ndmkreb7XlaYzKnhCzoYRh8Hk+C5BkI7wYeVmvJtH+8q0nE7C2VZpxdWJr2sX
         7mg9NYYsuuJae3u+Wx+G5FeUzFt7UW0OJ8/MEiCQsJJyS3YpkUVRH39UFb9XfzLZPgWp
         z8sB/pebAzn261yAyH8FLt2/gjTSm3S9jJd+ft0ZBpQRiKvYqjOQGe1R3PenI9Hzz3g1
         XX0RSuNxlpjEqJvIoyb65LhLzZ5YfXjjFdrY9TWMNUj6e2nK7Jd5UjJ0aQ6TKZL7xd11
         qhXho+G787c3Icb67Tr5m2nmHLaVw0RZnin4OVWuJWDm8oaD7FNk4N1CvWbA22uq4MX3
         tnXA==
X-Forwarded-Encrypted: i=1; AJvYcCVMQgxkPFPcH8xTsn6N4qE4y5gAuP18HtiFcHKpxiE4+NQ+/fh8q/F1SiDWemWbdkOPBGtnEZPEwVDEKfde3kupNjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfl3HQi/a14yGDz1DuM0Vbe00+ea0Up88OgdDZVcmMBNNq01ER
	KN+4lUlz38UXWl7320x9UKPqbyUsTma1VqWccG+2XGbKG6wZqp1NjYhLHAUhPTrJ957XIlsjf0Z
	3ubYTK2cHqJNMcV2FnL8ihSEYShkh7iwNd0Hkt8ncbT+P7ZHDJ8iSW+ufZlKXj+TBmqSaMHLTDg
	==
X-Gm-Gg: ASbGnct14Wgf2w5MP4C6tD5fqWCLgmXNkhAcK4nYNs64HZcjZBBksmmrL2hfile8U37
	OZVSpIo2YYlRFE62v7oXdP7wH++TDG1ndgvtaaY69ixmw3fXYahSwCLxyDmrbwva0/mOaspKhb5
	nuh0x49vUvgJhvkrIGOnIFew2Xx1cvymXUU4TCxsg9/Ch6fwSrHVWwusYLnDmNwnV7UQKIjZhLx
	yOvboGkxIUe4JQNybq7avipT3QCTUeiVmFu3pLft3DwJF7oPyqL0ng784re8FyNj4qcChba72Hl
	Gk7rnTHAKvHOt9WzqokPN0neTHG1apb5SHKjEzC4FDLzddKc6wNJliZCZoDWenKSnA==
X-Received: by 2002:a05:6000:144b:b0:3a4:f661:c3e0 with SMTP id ffacd0b85a97d-3b5f2e272e5mr15797883f8f.45.1752593054867;
        Tue, 15 Jul 2025 08:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAD/RPdEIGo+NLp2nTXtLdhtHXl+E8RQZSORherbEUs+bWoj5Dv0TdttD3NS0GePRkad31xw==
X-Received: by 2002:a05:6000:144b:b0:3a4:f661:c3e0 with SMTP id ffacd0b85a97d-3b5f2e272e5mr15797848f8f.45.1752593054413;
        Tue, 15 Jul 2025 08:24:14 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a62sm15212690f8f.40.2025.07.15.08.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:24:14 -0700 (PDT)
Message-ID: <17efdc2b3e206730cfbef410fc89a713da133b65.camel@redhat.com>
Subject: Re: [PATCH v3 10/17] rv: Fix generated files going over 100 column
 limit
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 15 Jul 2025 17:24:11 +0200
In-Reply-To: <20250715150828.BNdFfB8h@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-11-gmonaco@redhat.com>
	 <20250715150828.BNdFfB8h@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y0g-qSVh4feO86GrPjtOWW5yuxupxRoT8yvV_ZiZ48A_1752593055
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-07-15 at 17:08 +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 09:14:27AM +0200, Gabriele Monaco wrote:
> > The dot2c.py script generates all states in a single line. This
> > breaks the
> > 100 column limit when the state machines are non-trivial.
> > Recent changes allow it to print states over multiple lines if the
> > resulting line would have been too long.
> >=20
> > Adapt existing monitors with line length over the limit.
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0kernel/trace/rv/monitors/sco/sco.h=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +=
+++++++++--
> > =C2=A0kernel/trace/rv/monitors/snep/snep.h=C2=A0=C2=A0 | 14 +++++++++++=
+--
> > =C2=A0kernel/trace/rv/monitors/snroc/snroc.h | 12 ++++++++++--
> > =C2=A03 files changed, 32 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/kernel/trace/rv/monitors/sco/sco.h
> > b/kernel/trace/rv/monitors/sco/sco.h
> > index 7a4c1f2d5ca1c..83ca9a03331af 100644
> > --- a/kernel/trace/rv/monitors/sco/sco.h
> > +++ b/kernel/trace/rv/monitors/sco/sco.h
> > @@ -39,8 +39,16 @@ static const struct automaton_sco automaton_sco
> > =3D {
> > =C2=A0=09=09"schedule_exit"
> > =C2=A0=09},
> > =C2=A0=09.function =3D {
> > -=09=09{=C2=A0=C2=A0=C2=A0=C2=A0 thread_context_sco,
> > scheduling_context_sco,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 INVALID_STATE },
> > -=09=09{=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INVALID_=
STATE,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > INVALID_STATE,=C2=A0=C2=A0=C2=A0=C2=A0 thread_context_sco },
> > +=09=09{
> > +=09=09=09thread_context_sco,
> > +=09=09=09scheduling_context_sco,
> > +=09=09=09INVALID_STATE
> > +=09=09},
> > +=09=09{
> > +=09=09=09INVALID_STATE,
> > +=09=09=09INVALID_STATE,
> > +=09=09=09thread_context_sco
> > +=09=09},
>=20
> I'm confused, these lines were not over 100 columns. Same for snroc.
>=20
> From my understanding of the previous patch, the script does not
> break
> lines which are not over the limit. Did I miss something?

Right, I didn't make it obvious in the commit description since I
thought it wasn't too important.
Those are the monitors whose lines are going to be longer than 100
columns later in the series.

Changing it there saves a bit of complication in the next patches,
where I only add lines for new events instead of splitting the line
/and/ adding the events.

Do you think I should mention this in the commit description?

Thanks,
Gabriele

