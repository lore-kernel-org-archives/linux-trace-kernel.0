Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A622D8383
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102927; cv=none; b=I5VXfvxM6bPoP4Lhgyd68jYKXSkwGRLkfffwo8yv0HRYjDb1U5nAGqT+emy4qsNmqfalazO53OGy0hbnj1j69joFSZxHS52dfTg0t1uJJHmLeImrUhN06Uugfm1G7Q4ULFLgSFuTlg9HRnfAUtN3Um6+MigQ9oilcW17AR2aHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102927; c=relaxed/simple;
	bh=q5+0AJhrVXdKoYldfzZDifsC9giSHKKjvZEHmyGc5uY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XybI72utqWZQ7iaCa8SUz1q7bbxV9NlQHUyDGRvcU4m3KSyf19LHX8uNWecXrrF/YWXkkZVsR8sR7zAeosdHJWi2qYHU96e6h9gKy8ohIlrV8meXJdxnbnTG+dBW8BDo/661+hwm8XP64359fVz/BYzjreGlwX/5iSvI6zykhpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/ucI4yB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/ucI4yB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753102924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q5+0AJhrVXdKoYldfzZDifsC9giSHKKjvZEHmyGc5uY=;
	b=W/ucI4yBATLKDwAGL8FyUiAdWg4BscEljiX9Rhk1dDFI4HQ4wkvckdom23KI0oT2rLWPs7
	EBoqDEAHJvcZKOu71DqukThPyEIxYO1NtfVy0HexbENxVjU01rCr1785TUlP3CFsbHLNz4
	/sa0yhR0KLm6BO0vTb9ZOM2lXN8PKAM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-zS4NkrjEN22XngiRe5zdcg-1; Mon, 21 Jul 2025 09:02:01 -0400
X-MC-Unique: zS4NkrjEN22XngiRe5zdcg-1
X-Mimecast-MFC-AGG-ID: zS4NkrjEN22XngiRe5zdcg_1753102921
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45624f0be48so24280285e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102920; x=1753707720;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jD+wnTaKP0Y8e6Enf/no2sGgqHNYlggzCKTqQZCB61Y=;
        b=NcIRI4u3QC8F2NyxhbYfLYOxcn7aHbzq8an8JGqw/ias488hnafPeE7y+cwtBbusX/
         3k9hScir7QkV5dfjNiQIuLt0JqXHk43zSBz+9qV+zy0WboI9hv6cIuKvaXV6sivI0vX/
         s29sNTB3c055DvRhEYOzg7HExZ4NW6jDkkwUqh6ZhFkwSbwa61rMQHA3DaSwf+sg3wm0
         uHpTJvNggvGPvHpPKg13PHY3cDkMUN0sLb4RpmjV8nZnPVPLLssPukO+LYnGtMK0Rub1
         9UQMEPigqgoHXr9fsgqdQzz2TtJU4cNIqJ2/bV2ewSYgfQe8j37WSPYDUs4g6vz2bAoW
         98xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGPgH3p9hZrLQXyZZgJfRpenCsy98bm5qj4JCz4BXURKXO/vAZSVfyV34lfS1+1Q7nYuzHEbQZGEeD8nai0sN7boA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpfmy9fk90wCjipANf/Rc61dSaokQi+JXO4jebE3laRb2X+cK
	TFwPX0O2Jpz2t1Yi5BY/WWl1QxM/T5kECfiABRhGjJpgYVJFjNq06jT+9ddZJHEiAcrAc0xv9bO
	7zDgEOUZ2+riVVWW/IID/DTPEjr1zu5RvxA7fbOhu0T4gTVg8rDVu2A8X8VL4E/SzyjbC9RfMcA
	==
X-Gm-Gg: ASbGnctEcnjTYsKBBel8APw9UYX1LCTPhaXqEnmtFJx6PmBxwvgHVu5CB6YY82EY9JN
	NnSV6IGa2adZIPkupSLLHMuA7GEIbF/sLm2AyAx+FfmVnwyvTJNFQTadV2KN1ffUXJnDAg8Q+2q
	STjPi8ttXMFlSCzbe+huSi9oQXFbJh8v9hkC9iTBjxrooaOgxIqu4w3eK3K91CUsA+XADQS8M2t
	8eC3B6sBA48nDH+KpoR3RU/cdSHnoXboRW8AV4HSDMlUMEtf2UmK3+R20zzZ+9dItjwfMV1GSJb
	YCNGzgXMCoH3a+Nw9l8cCYAd9o/5B2J857f/AeumQIz3KKrC+EO7GV4sCkB8AnImjQ==
X-Received: by 2002:a05:600c:310d:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-4562e2a59a6mr217518645e9.31.1753102918091;
        Mon, 21 Jul 2025 06:01:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz92oHW6cf5bePbFRUQ/bTAGdOdmnzzYqC+rPHlpMjNIHtv87b65EeqIpUOgFuaRe0qdZRrg==
X-Received: by 2002:a05:600c:310d:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-4562e2a59a6mr217517285e9.31.1753102917018;
        Mon, 21 Jul 2025 06:01:57 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886286sm163348015e9.26.2025.07.21.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:01:56 -0700 (PDT)
Message-ID: <ea84a5ea39092432804bc7c63596892fb9fdf511.camel@redhat.com>
Subject: Re: [PATCH 1/6] rv: Remove unused field in struct rv_monitor_def
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 15:01:54 +0200
In-Reply-To: <68e223323b11aad9934344ec1764337b2f18c080.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <68e223323b11aad9934344ec1764337b2f18c080.1753091084.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: _q9rbPFl-Zwk5qD22Ivqk57VxAZznCPKaUOkRPu-h6w_1753102921
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-07-21 at 11:47 +0200, Nam Cao wrote:
> rv_monitor_def::task_monitor is not used. Delete it.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> ---
> =C2=A0kernel/trace/rv/rv.h | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
> index 98fca0a1adbc..873364094402 100644
> --- a/kernel/trace/rv/rv.h
> +++ b/kernel/trace/rv/rv.h
> @@ -41,7 +41,6 @@ struct rv_monitor_def {
> =C2=A0=09struct rv_reactor_def=09*rdef;
> =C2=A0=09bool=09=09=09reacting;
> =C2=A0#endif
> -=09bool=09=09=09task_monitor;
> =C2=A0};
> =C2=A0
> =C2=A0struct dentry *get_monitors_root(void);

