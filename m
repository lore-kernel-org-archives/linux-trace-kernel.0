Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285429CB52
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834424; cv=none; b=Yo3+EQPjuDkOv2wxslwWaGZrTThByoLsFoBX1bjKcT2jRD+fs/iacMInggfuVZYogUBEaJcl2wOZ3DImekFgGa18fSS52fTbxMH4WZm4Ftw5LohXGdeGLts4+3uoZ2ytId6qhrqz15nB9h+RnTeZZsXpXcb4NQCiHbYKGOwCLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834424; c=relaxed/simple;
	bh=d71UqziCB1PEqXMxGJqpbsDzqYOwk82CEFioZiPyyZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0VGxduino3Gw58NECLHR/07nixzJ2pYqQyBXtIVcBpoXFwGuNLS03ngrg1YHaxD1x1eBcMRyMNWjYxZo7ZD751g+XMe26rT+Bt4RSu55slnIasalMJVFq/CQ3UhZ9L8Ffv+BBfvJJUHB4hOCuQ5FJnznQoswwDoyE4YRrYj1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ey+0tlEA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey+0tlEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752834422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d71UqziCB1PEqXMxGJqpbsDzqYOwk82CEFioZiPyyZQ=;
	b=ey+0tlEArXMNs/tr3wxApEYjW65lI8yKtgKyr8/YvPkCONpExPbBRUHbKrgdFqqmLG16PE
	J9155tug0fBuAF4pNf2LUuB0xJtOGz2cMvymIzX4nTVxh8HcIjIy0Ci6RrYspm56jVfkma
	VKqkcWVmwGxRUKI9KcMMc4sNot22cE8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-RdIFGAzdOJuZyjovQF72bA-1; Fri, 18 Jul 2025 06:27:00 -0400
X-MC-Unique: RdIFGAzdOJuZyjovQF72bA-1
X-Mimecast-MFC-AGG-ID: RdIFGAzdOJuZyjovQF72bA_1752834419
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so910830f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834419; x=1753439219;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d71UqziCB1PEqXMxGJqpbsDzqYOwk82CEFioZiPyyZQ=;
        b=m68M9VOFzHzib3nHLGQom5kGXx8sm/+aTXv2MSXCy5w/4gXkMe7t+SV8bQc24OTkX5
         /ukM3q+JIMcbhzB2gM08Hph6YgD3aeMIcLAR4851vs+HgUm6RaFoeM9/qGpjn3aZnenj
         rhoDN1foHkBzQ2QYacv+Vm9rvCkzFcPQ6lDHZAPKPEQLTYz+M5yOqZrlNATZZoYXGmrX
         ys9OPwGjQxZZ+y1Rt2XPnRa7NW9sYt3oVjh3ecI7Tez8jdxxKthOEMR1eDO3kr5QWeXd
         1rY4FEnC7a+tKRT3QcGRygl8X5McMQscWismulmLSovnknYjT6A31kk5uewyQjzil8c/
         ggBA==
X-Forwarded-Encrypted: i=1; AJvYcCVTa4ijVslMen0xFcWmk3aYGi+EEcCybYRAhTV48NpsB1A04sL7WkkgjwVCJftiKvRAeowWJbsXX1iuxw8gIs7RLBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDw8bt6ov1ZyPIMQrQzsVC0wLZ1bNCNONlosMWRd6/J9+5bQAH
	CyGGrY0BxLEFVDwjRqmUOVYN5XZfEaOUFYF39WNH3UF30Pj+Ert+sEYKdxTRD66ltBaGN4Hv5Zf
	2is6fM6J5D8Toh9he/HXGdm45cS16iFkJ5kFf+3J72kfN06P7mYM8aj1iWzl4JF98qg6qH67Ogg
	==
X-Gm-Gg: ASbGnct+yWTC1o/gpD9Yp2DXQVjjDlBtSnJwjGImf3pdEhOIX1yhwjdgt6/rbqH2sNS
	BtHPIIlMZhm9ilhixF4nRwflgiaJnM3Rg06+aZRAJa8x8xg7wq/9H+KuXorZk3BBndkJHghFCjS
	c+QUckmOrd5Fixy1NVrgrDCnPaWySiHDuB1eK4eL2A6uN7VcndUmxuRiBHL/57lrZ9PjAZfyHPL
	oEIqy5ONlcmLGHZN+1dagOmIbfSaEFJ/Sq1kYRprez66+DFFFtNK5pymcWSkDIvbF3CrsKu6ux6
	riFZZNmR0Kdba3GNB/a0tzxNMiuXQK096o4ASrLw2iBtC8nHM8hJmaEwEwrd92tozw==
X-Received: by 2002:a05:6000:250d:b0:3a5:58a5:6a83 with SMTP id ffacd0b85a97d-3b613e66eaemr5223586f8f.13.1752834419496;
        Fri, 18 Jul 2025 03:26:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpi/oLZSfF2NXEYGs/7vTSjp4YTnet4cpMnngioIMkIsZI/XYrA/Hg+gK4DTjgtUrkSgaj9A==
X-Received: by 2002:a05:6000:250d:b0:3a5:58a5:6a83 with SMTP id ffacd0b85a97d-3b613e66eaemr5223568f8f.13.1752834419110;
        Fri, 18 Jul 2025 03:26:59 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74029bsm15741565e9.22.2025.07.18.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:26:58 -0700 (PDT)
Message-ID: <b9b66047398157a26ea78017d3b36482fb67226d.camel@redhat.com>
Subject: Re: [PATCH v3 17/17] rv: Add opid per-cpu monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Fri, 18 Jul 2025 12:26:56 +0200
In-Reply-To: <20250716093825.rWXnBtv5@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-18-gmonaco@redhat.com>
	 <20250716093825.rWXnBtv5@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: mSBk7FyDuQ8YMhZNvC3AqNLw3IPzZomUUz_-253mSjE_1752834419
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-16 at 11:38 +0200, Nam Cao wrote:
> And the monitor reports some errors on riscv64 with PREEMPT_RT=3Dy:
>=20
> root@riscv:~/rv-tests# uname -a
> Linux riscv 6.16.0-rc6-00054-g7590637d9ca2 #87 SMP PREEMPT_RT Wed Jul
> 16 11:26:00 CEST 2025 riscv64 GNU/Linux
> root@riscv:~/rv-tests# stress-ng --cpu-sched -1
> stress-ng: info:=C2=A0 [452] defaulting to a 1 day run per stressor
> stress-ng: info:=C2=A0 [452] dispatching hogs: 4 cpu-sched
> [=C2=A0 614.390462] rv: monitor opid does not allow event irq_entry on
> state in_irq

Finally managed to bootstrap a riscv VM, that is an error I thought I'd
fixed and I'm genuinely surprised I didn't notice on other
architectures.

Thanks again for catching it though!
Gabriele

