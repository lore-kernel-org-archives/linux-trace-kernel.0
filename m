Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760D1FDA61
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311980; cv=none; b=Mvpb7LGD6yvWL6HWhoJJgI91+sJJtcsT+Fe+munx6ajbMBU7GJqUHHujHecq41batc4JVffp9HmS8z1ETxUWlMoBakjfR+NAjfxFZ95tgxhErK0AURGlgyaoBEoGoIj0KWK3PQLsIOUQNM8AaxVn7CpE1HLGt0TRH/MSgc99Za0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311980; c=relaxed/simple;
	bh=ZQDNGSUawC08jjcvn/R3TGfNGjmLvryin4H5VAlkPy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cWY37U+RxkANs7oJnwRmvQzjZYFmN3ga6AZ3Jr0cPwpwc3w8uDw9euPhMjQRGEZi6rbqB3HwLGEXVVsIm5fdN2hau5Xkp8y6yGaEmhlEF6ZxD9no09rdmBb3DBEQIvnYxXS76hl7FfkrWmjyQaLkXZ7612uRSJ4t+dgGe1pXaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TM1Kmj81; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TM1Kmj81"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773311978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O8I9IWEr5vJlFRSOr22xQTP0bqXnTuN0yOqYjNPkcXw=;
	b=TM1Kmj81eJPPNz8g/bdhNfrLycpN51FttV/EPjfDKZ8g+6U2KPBOXBM2D0SE7SGeqwuHiw
	5mc2W8Z/Y5834Am/68TX9jpNVvo0EdWjWCGJSZbJN6wM7LQ9IzP5220U6mBFwpiFhuTKs/
	nzpE773V4g/cH8uDTZ7VB8mIWPMxisQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-QA4HqVu_Np6vws3x--zRSA-1; Thu, 12 Mar 2026 06:39:37 -0400
X-MC-Unique: QA4HqVu_Np6vws3x--zRSA-1
X-Mimecast-MFC-AGG-ID: QA4HqVu_Np6vws3x--zRSA_1773311976
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4852ccff333so6685135e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 03:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773311976; x=1773916776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8I9IWEr5vJlFRSOr22xQTP0bqXnTuN0yOqYjNPkcXw=;
        b=qPpEfXocSLNzjEjQNpCyfAZ7mf+eJ0sLHEyVqW9IUrqPn+R1oG00CJx5UwNOEXQGWf
         VDCXGUfW6mqDa6e2Z2ywMNVrBZ1JtwOUcayUIxKgVARjFih9p4eFzKRxtEQh+POFf5Eo
         WVUnq6EwbnyjOvvx2smb/fk83KqYnAlSCXVktxyfqh6F7c/LsqgYyCZ4rBzBJ+kGD5G2
         gtrkJagG2aJMB4/kDjJx8HZS+Dbl5ZpeyfMCfhpbtMDwLMlRqRvf/1ODZPUP91StbdVI
         5InUuisjvxaig3wsR6eijBhLAt5l1syvwqcYrTaGVtsWXN72FC9bGbTsIjnbOCS8qR/G
         jVVg==
X-Forwarded-Encrypted: i=1; AJvYcCULATW5ppCMoCxmpcUQurMoKd4Xt1VcyOUeOPmO8mVyUXDOwL58AIdWQipL4G4whzvaEn9CwDQ0A3TXrMcW0RIfApA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtejKT/OIEW4zVlAy4Onxhc3bImGXvqZPttjRje3R2S/YitfVA
	oEj8twQydXc0s91A2EOmBZjj9DtyYxYhDWfSghjdeMOdq5Iqz1O6VmZkeCauaVanRr8KvuDL8S9
	iauqrNqh7HI52k0Pc8ZF1kXZSUOypbpu6/1caoDM7R1nETotkbFg5Jxo3XnDvFQ42qSX1+5rNdA
	==
X-Gm-Gg: ATEYQzyseIdRe8BegLGRpbNjzpzZAenHFyHP78iwvnwbxJmwWzLJVwRB/cW6CdrZMNt
	p7Xja/BmtmnuxpczMtNah53PUhpYRuFo5YoRA3EBVc7jXmWevtLGtwoAn+reZr2ihjbe86XTw7U
	er0y8IpvZE48nGmQR/nyd2Ci4zNMyHtYxY3bzXx+wJApBLROJQP1oIGx+26XM3WP8Igsl2Nufh7
	ZOYZBnI9g1zuo0CBmjDUDNAwQ3SRoQMyQtbQxNUxWmLQTm8vdRbrShKr7N0BDXj1Brfu6zZS9x2
	1ZcqlCFTJ+peI1Ry9Rssv0ugR0ZHscQZ+fRlB3Bto8cWBG749woQeYA8VyewTIB0dzYeWCu6xQI
	CCX4MvDNImPyMaQU6q1W3M9unBLCWiTveTMYhDK27F6eJSym8DrQ=
X-Received: by 2002:a05:6000:420d:b0:439:abcd:b314 with SMTP id ffacd0b85a97d-439f81c5a51mr12034997f8f.18.1773311975782;
        Thu, 12 Mar 2026 03:39:35 -0700 (PDT)
X-Received: by 2002:a05:6000:420d:b0:439:abcd:b314 with SMTP id ffacd0b85a97d-439f81c5a51mr12034946f8f.18.1773311975308;
        Thu, 12 Mar 2026 03:39:35 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.82.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19acbbsm7497086f8f.2.2026.03.12.03.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:39:34 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:39:17 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v7 05/15] Documentation/rv: Add documentation about
 hybrid automata
Message-ID: <abKX1XO4vqY74uA7@jlelli-thinkpadt14gen4.remote.csb>
References: <20260310105627.332044-1-gmonaco@redhat.com>
 <20260310105627.332044-6-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260310105627.332044-6-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _mwkkDh4NJathkYCF2OjnoxD5KTSsiZ9T2EAtmsRdzM_1773311976
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 10/03/26 11:56, Gabriele Monaco wrote:

...

> diff --git a/Documentation/trace/rv/hybrid_automata.rst b/Documentation/trace/rv/hybrid_automata.rst
> new file mode 100644
> index 000000000000..60f6bccfba38
> --- /dev/null
> +++ b/Documentation/trace/rv/hybrid_automata.rst
> @@ -0,0 +1,341 @@
> +Hybrid Automata
> +===============
> +
> +Hybrid automata are an extension of deterministic automata, there are several
> +definitions of hybrid automata in the literature. The adaptation implemented
> +here is formally denoted by G and defined as a 7-tuple:
> +
> +        *G* = { *X*, *E*, *V*, *f*, x\ :subscript:`0`, X\ :subscript:`m`, *i* }
> +
> +- *X* is the set of states;
> +- *E* is the finite set of events;
> +- *V* is the finite set of environment variables;
> +- x\ :subscript:`0` is the initial state;
> +- X\ :subscript:`m` (subset of *X*) is the set of marked (or final) states.
> +- *f* : *X* x *E* x *C(V)* -> *X* is the transition function.
> +  It defines the state transition in the occurrence of an event from *E* in the
> +  state *X*. Unlike deterministic automata, the transition function also
> +  includes guards from the set of all possible constraints (defined as *C(V)*).
> +  Guards can be true or false with the valuation of *V* when the event occurs,
> +  and the transition is possible only when constraints are true. Similarly to
> +  deterministic automata, the occurrence of the event in *E* in a state in *X*
> +  has a deterministic next state from *X*, if the guard is true.
> +- *i* : *X* -> *C'(V)* is the invariant assignment function, this is a
> +  constraint assigned to each state in *X*, every state in *X* must be left
> +  before the invariant turns to false. We can omit the representation of
> +  invariants whose value is true regardless of the valuation of *V*.

Very minor nit, feel free to ignore, but ...

The formal 7-tuple definition includes 'i' (invariant function), but
unlike other elements, 'i' isn't stored in the automaton struct - it's
implemented as generated code in ha_verify_constraint(), IIUC. Worth a
brief note clarifying this design choice so readers don't expect to find
an invariants[] member in the struct? Here or below in the example C
code section.

In any case,

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

