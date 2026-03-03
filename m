Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990B3CCA0D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Mar 2026 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549519; cv=none; b=RS5ks4uMIwvCdzNwcwKm6jSdxJC55zusnPb88hIXgRLcwS5oX3bbDIxdY3kKDj5LoIemHHMYHq+wQaGhBRv8AK87aeT1m5pg8wmHE0JT6Im0TywHM2n887Dzll9NPbh2xaQ9sBkGNQ5b5ftUNmUJRJATUvxhHQ37tVnz64wsu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549519; c=relaxed/simple;
	bh=VcTAEuXIgazbam30v7h0INbBTK6ykVLaAc+NDs8de+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqplPyYIc46oYs+SZ/fgd+JK9sF5oAJrtvcUDYTx6ty7fkJnQs0wUERYYvse+RSP+DqfjnVuXvme7wKgK+RRl6V5Pu7LcglgcRX2f8MEZ2/a3OiXx9YV7lY1IGfTE0u2+4/uIMFUle7CpVqmjnoLCPwvx0E1syc3NkCJV2+IaHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUN/9YgP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUN/9YgP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772549517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcTAEuXIgazbam30v7h0INbBTK6ykVLaAc+NDs8de+k=;
	b=UUN/9YgPOeFIbRPQS8zDfwDpanwpb/Mxg4/qZ/ICuQ3vHbVxowLKKSM5AXU32HVrCXpf0F
	iIq49JHrU2hhnDk9bk02YZX0Vjpj/IcZV67HBmY2ZDzohhrK3ms93/urc8siWZsj2X+bUN
	jE+fabNXt5yeMVJMV+P7IQcJqvrHCcY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-gAeXoF8GO4eZMJyFYfgYmA-1; Tue, 03 Mar 2026 09:51:49 -0500
X-MC-Unique: gAeXoF8GO4eZMJyFYfgYmA-1
X-Mimecast-MFC-AGG-ID: gAeXoF8GO4eZMJyFYfgYmA_1772549508
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8fa5744b82so595641866b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 06:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772549508; x=1773154308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VcTAEuXIgazbam30v7h0INbBTK6ykVLaAc+NDs8de+k=;
        b=JUHPbWbWeZ5tevxUHyEEkCWM3VXeLYpiEsEmaGxqBsmomuuIxFbWwdBXopkWpUQUTD
         jc9Ub8R4LeD4dQ/NVheuC2b9Kik47N4gnKU0fJBkrQ1t5R8XEueRjYW2DSRJdLb6vCd0
         giut7PawwXr+zqFs4GR353NTqN4xqZq+WCdJQOK2imDdDR+eQlG+opvwq1dcwYbWB+8R
         yUOytCPT9dPr8pzJ16YIJDy/+DDoYACFfzEwCVt6oXxS0MC1bouCKijdihap5r+A8O3l
         Gxk0QJoL+m74VRVBJf8KH6PlMvBIsIim1ha8eGgraUE98Bs/S2upJbCZKEEMH6i7FSQw
         ixag==
X-Forwarded-Encrypted: i=1; AJvYcCWWNnCchfSkSnqpjN+TNWm/eayYecvEdRC8p6ZjsyF/k6IjQBPvAT44SV0tia5UqsnFMeGqvBzd9mHYg+miBdqc1VY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzv4ppo6KHXmNZIXGxl/+OdV0ATYTU9GyLPiAF2+eylc5NWp4S
	B2Pucq/nDCwYJwkjnljLxVgFJIqciKdnRN6WKIxjfQ8i5FB0CMm8I5OOwn9hjNXNlCjYpdaki0K
	ViyYhssrai6j01LMGFF87h46oYhy0v0ExDkGoVgvjIDNFXKj6BMQ89EaxyN5SbVtAY8fn3rbLEA
	5fpaPjHqAYQfoCtHBZpH+jnR1t7r5j00I80GgDBOuJBsj/AHgBLtKnklnk/qJG9A==
X-Gm-Gg: ATEYQzzH+wu52zzC7tiImBRQH+Rhj+n8Nz/zupzIr2UQhLxIWE+CaExPXAfHqn7jjN5
	3T7s6EcZplKWwgncshOgRp/PrAOgkoBzp0fFg2ICB6PpR3o8b/BGEkFdsfBydyTx3+/mKPyFbLY
	2b/ZHqH1bHY1llN1h9QELRxFukmdZjsMhyycIa4Ze6fo1t5ebpIOo5pl58MDtO8E3L6WLMdjJ5h
	Oz43g==
X-Received: by 2002:a17:906:f5a6:b0:b93:5fa8:d7f9 with SMTP id a640c23a62f3a-b937659f053mr1099834866b.56.1772549507740;
        Tue, 03 Mar 2026 06:51:47 -0800 (PST)
X-Received: by 2002:a17:906:f5a6:b0:b93:5fa8:d7f9 with SMTP id
 a640c23a62f3a-b937659f053mr1099833466b.56.1772549507290; Tue, 03 Mar 2026
 06:51:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-16-wander@redhat.com>
In-Reply-To: <20260115163650.118910-16-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 3 Mar 2026 15:51:34 +0100
X-Gm-Features: AaiRm511X9QNsDzw92mihpQidwgDFGXSj9GKUHHxoZ4yY1UDj2VYOgC1182-m6U
Message-ID: <CAP4=nvTy6AE2i6ziW+jtWqrDR3CMVPDMhNE5bp-cVMs9_D=k+w@mail.gmail.com>
Subject: Re: [PATCH v3 15/18] rtla/trace: Fix write loop in trace_event_save_hist()
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Haiyong Sun <sunhaiyong@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j6tm8dn0gKmaAS4FdONi0eHfA8Qt5Lsbv8LEtl-qftQ_1772549508
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:29 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The write loop in trace_event_save_hist() does not correctly handle
> errors from the write() system call. If write() returns -1, this value
> is added to the loop index, leading to an incorrect memory access on
> the next iteration and potentially an infinite loop. The loop also
> fails to handle EINTR.
>
> Fix the write loop by introducing proper error handling. The return
> value of write() is now stored in a ssize_t variable and checked for
> errors. The loop retries the call if interrupted by a signal and breaks
> on any other error after logging it with strerror().
>
> Additionally, change the index variable type from int to size_t to
> match the type used for buffer sizes and by strlen(), improving type
> safety.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Looks good. Only thing is that it should have a Fixes tag so that it
can be detected by automation (e.g. stable backports - as this is
relatively old code), like this:

Fixes: 761916fd02c2 ("rtla/trace: Save event histogram output to a file")

(on one line, Gmail may truncate that)

Tomas

