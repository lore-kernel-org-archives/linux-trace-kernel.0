Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE172F4A16
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913514; cv=none; b=DlD3mPVcyRGZatkZ4AAv5N92jmojjWx+r0WpW3E9J/ozQCLyUFg4jMBXH7B94jbGgmh/ZrjkEXXOE9kiqVxQjeQChFKQwz2L5fh5oCgr4COblmHFtca7b1nyt9k6mtep1xw5EMNJOVdaMkM5h8zdQEb/AV3U6qrDn1zLb0XFs5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913514; c=relaxed/simple;
	bh=K1jLoSzEuFbqSezYfnU5tiO0InkAWReSzsHqNYir2gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzSFUN3LygC4DJYuuBzbpYDsD6jI5Sz+XJ2gwNGYym/qzgn5fUvuK2puE+eNzHLsGyr/EFgBgZo3mmha3ju5QQGzF9FOGEp7J0cbwWcUfrMBQN12EOmCWQvWQR1AtHaJoeCzf8y01DFswPgnWbBhSME+W96t45kpFHXWNrM+SoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYrCExUK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYrCExUK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759913511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1jLoSzEuFbqSezYfnU5tiO0InkAWReSzsHqNYir2gI=;
	b=eYrCExUKHdGGGxlBZx4q7w/wUeO/Y85AbM4PMugQu72/wNnbzxxVNGJX882evbCSIiY0af
	cMYixdShgWFmr0sU6c4kFrNUKZRNpOy4scO9H5kIoa6iWvz/SMQAjzgbjRGlOwrsVyMI2+
	S/C0rh42jx4Rj8fn2pPqIPOLcSn1cRw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-zuwl7RKSPzSQx-UmYxhHmw-1; Wed, 08 Oct 2025 04:51:50 -0400
X-MC-Unique: zuwl7RKSPzSQx-UmYxhHmw-1
X-Mimecast-MFC-AGG-ID: zuwl7RKSPzSQx-UmYxhHmw_1759913509
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6349af0e766so10650060a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913509; x=1760518309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1jLoSzEuFbqSezYfnU5tiO0InkAWReSzsHqNYir2gI=;
        b=Cg8KKR2uR6QAUSjj4TvMLy2qSY0b/LF/7VNASxPyZEfd9gnj9HpjdA5ITm4qVJNzFG
         WWpsc9q3WtUb4NLxWRDkN3/ai9JdR/rVJ4syFHL4PFzi7ykTKaNYoZR3xuBt6DVTRawn
         TNMvZMjGrnvesp7ktnfKYVwuRbA3dc3AZcIZOoeSDYdsOqhOKhrK7iWK9CU8/FOFFsTu
         KZKxHkamfdBXk8geL829Q/CUTKBf44N0S426PF4lN03qZW/tbqJiuSCi0RzFr9FTAvWQ
         Bz/gHhkaT9+BgmggEW0yQ/9oO+NTe4b4uptvpiGGutvxcEYSBDSPGvQKg2C8fNWJVT/4
         Acqg==
X-Forwarded-Encrypted: i=1; AJvYcCUdm8YtVV6fx8rNGvxxSXAqoyklRFxdUqDFAMj1zV+wZV3l57YNzfGn0PyPdbqNnEpnmUJRX7m91YSEl2yR1EYeyIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ohipyNuwxbZY4zT8BrZB95SuIbgTm7DD7atFrGlHXb3LPei/
	tVkma0GCCgfLYZq8EB9ToxQmZCvBRv+TXNAXrteWU4ebwiwTfcOb6lNtjrNoAxyyCRZRsO4q18g
	gNHQQVZOk0WMGaYCTU4lf2GcqIYfmHXEhh0HJTQvDlOJj2b8AsUpNSll8EjECxYk9hv9ySs2MwE
	xKlLTUEMLoZ1HxC5H7uokBHHDF8CJCtQ14vNgRljHnchscBi1c
X-Gm-Gg: ASbGnctYdQfDhdZIIpCmgJ9RZAIztHtKYWE0oY6hBm3TF1db5qWTcQdnxqy58un5PfR
	lyJx3YJ/kdLFj40ovDdfBjmBhQG5j/jNprBkyrOft7JTSnmv1lULBKT7EIThH1zpgXfHQ9hcvU2
	pWc3nD6iTSN4Y9fSjqqYuPvX+LYOuZasayJcgGVQPBS7gw9PL8suYnAeME
X-Received: by 2002:a17:907:6ea9:b0:b0b:f228:25a with SMTP id a640c23a62f3a-b50ac8e5713mr267298566b.64.1759913509018;
        Wed, 08 Oct 2025 01:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlLGykibVDcNGYWtPcRHTDtWzH2pHaHbQcQI7lpz4Me5SQM9O1QhytKqyATgl/LGApHGlZOh3ARmF0O5i6ufo=
X-Received: by 2002:a17:907:6ea9:b0:b0b:f228:25a with SMTP id
 a640c23a62f3a-b50ac8e5713mr267297266b.64.1759913508644; Wed, 08 Oct 2025
 01:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOUMyGvkibvOV0IS@archie.me> <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-2-krishnagopi487@gmail.com>
In-Reply-To: <20251007185508.40908-2-krishnagopi487@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 8 Oct 2025 10:51:37 +0200
X-Gm-Features: AS18NWAa5UqMYPtJx16YwJk94Bme1M1kIPV6ZVpINM7KtV6NNimChhhnPaGzQko
Message-ID: <CAP4=nvTjauRawBPTnGEztZpdDSNhGpgSJtjoTFuq+cCQHP5oEg@mail.gmail.com>
Subject: Re: [PATCH 1/8] Documentation/rtla: rename common_appendix.rst
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com, 
	costa.shul@redhat.com, jkacur@redhat.com, 
	Bagas Sanjaya <bagasdotme@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z6r_5zAOQVxID5WOz4FNKfDXVdRcRHIAx3qyzS6RLAQ_1759913509
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 7. 10. 2025 v 20:55 odes=C3=ADlatel Gopi Krishna Menon
<krishnagopi487@gmail.com> napsal:
>
> common_appendix.rst is intended to be included by other rtla documents
> and is not meant to be built as a standalone document.
>
> Rename common_appendix.rst to common_appendix.txt to maintain
> consistency with other common_*.txt files and prevent Sphinx from
> building it as a standalone document. Update all include references
> accordingly.
>
> Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---

Thanks for the patches! I completely missed that the refactoring of
the docs broke Sphinx, I only tested RTLA's man page generation when
doing the review...

Could you squash the changes into one patch? See the kernel documentation [=
1]:

"... On the other hand, if you make a single change to numerous files,
group those changes into a single patch. Thus a single logical change
is contained within a single patch."

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
separate-your-changes

Thanks,

Tomas

