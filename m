Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9286383C64
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611393; cv=pass; b=nf/laXXUNRoQCq+oyaoWYPDSWi58ZxZeqWQLtiEwMEQU37Vki6YUbcv9W+DqftKku1cAdpc9YEkkKqnS76VIZy828meAZGeOyEV8mPtCXvA718V9gz+jc6mSBjrTLGoImBgbSMydLuY6/lwtrLnwhTnTt+LZQUUIbQPxdoOY3u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611393; c=relaxed/simple;
	bh=WJBrs4T066GuaDC4D01bHRQo9ktMEwyu0T91k7Uq63A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J++YGvWHtMgPlCNQ7bF5qGcW+i72tViR/Sj/fLPDwCD/fJibOQS52rMGlFUYJqcH8e6NUHsJdsWOPpw5xwmzewUOagUGIS+41fos2cMvarRJ+gnq1Iy5r7L3P+gQEmUXvwoa54+iC71Z8W0JBfmWAAvDU4g1NLip1KUmpeCD6Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX2FdqUS; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX2FdqUS"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so1485778a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 08:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783611390; cv=none;
        d=google.com; s=arc-20260327;
        b=J4IY2TlBPLnIOvJH3Jmy/m0bxzp5ozKJDvLwv3uXL4rvsh4sBZBcAaKqGjdVfvcqml
         oT4vCes0jI80FtNE10Adu5PhyWpghddKe2thxobUH0Fxk1Ucb4ttIwZnYchZq9f3zqrY
         VfHV8PI3RY5kTdW2uS9gGEHP1p7tpr0MMjokF6xjFh3d/AUC4UYMj5CrfCMhabcsgWWS
         jsxt54ZjEyWGIYiIOkTg0/yBRjY4ID73XT/YbvFiyU9QaNY2l5TlZcYc9YsLi0qPpZSD
         hcrsvA5bOrUo8UdeNYKhJiCRlcCc+3KYPSfr4hEzkYGsN+7t4FNoDJ8zLivLfe8tsgQ6
         uO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K3EDMCNVkT8BPRGb277v4lxIK6m6j8prIJdEJ1/EtfM=;
        fh=3OY+y6UtTtdJRfipTCeWvlnsf5mIZoFETBfpOo40S7A=;
        b=rM9RBQ6eT7Ah/+KykHKxxMxy7YvPUhEyTqTVNFknIp5BntOHGFkUGpGSdLHMQOc7mK
         oQe5F/iGRtTf+7EAwkZokKhVw8wMIRW0ObuY7vqp+tSEvn5ONK14r3/jeVnhnAicE7Ml
         7eXm5bLgJDd5mZjsIAW93SsGRL6AOVd1R1qmGY54JW0EzhI7u9d9cWJPxgngbwB/tkEp
         0eC31wJXDiSYkQiNud5CuPyUDBNFipwKrp2tyWSqcMKS1j2PIdYfdskpBsFR6sJEjTvv
         /027MFcxmomVeQLz5Uzoz6JhPqNVkmeFpxqH/4gv//pqObSCD4WtTyZumdRkqJN0dOOk
         uZig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783611390; x=1784216190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K3EDMCNVkT8BPRGb277v4lxIK6m6j8prIJdEJ1/EtfM=;
        b=XX2FdqUSSnKcboVj1klVklwkW1I+9ZQjF9wqHr36MhNbCM8Dx4rKVNtCCJBN0l+o6Y
         Wb0gZXzQEYDJRf9h68KkH9VGp9iwqVPGisreu1WSGzRa1j3b92fhMDs5n8giF31DIY7B
         yFtWwWeEMyqrCouEkLl2t9/VJ4BBGpynDdYcPN0Z7Z94BqoPdD4HAvxsV5oR8iZPR5Ug
         SVorFbsY//awaAF/jNiQK6xi/+7EI1/AXBExsXjS/d7LY6gxHgpjW2mxksOvMMtO3xv4
         ssFv8iTEmkxasv57BkxCdN/qMPI0yjlGUHIFqg2FcEIr/akZNObFhKoclNInT2v21RDC
         Ek6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783611390; x=1784216190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K3EDMCNVkT8BPRGb277v4lxIK6m6j8prIJdEJ1/EtfM=;
        b=nNZsSlo4mcUBh/Aqs0pQA/4KV29AfqVptPMrXMNk8WXLpvdlIeACQe5DpC/Hux1c4+
         /Qrq1zXqo31Pm+iikcDoXShCPRpkTVxP+sSIVdRhEP/vr2b9YP3ZYWttIVU42USczqeI
         VMvIp8rKEh0hKKnWZHhLTL8+j4XCmtvjkcbjpHBzdTkcGTv0tTyQx8oApaqW/lRknnkU
         N5CWjfeHfo7Cj/KDmfwSXSH+MeCde3upRITf/CEgCf8rbFSdFPAvz/WjmHxWV6dEXfdf
         6KhBJAS2COpnIlFe4uLCdaZv2hBIXpLuhv41xaQcsYy5PtTAv4yt1sURmDyLoC2GjjE5
         j7Yg==
X-Forwarded-Encrypted: i=1; AHgh+RoQzsaa8VLDfPjtAz7v4C1Ya0jueKiv/kv7czRPRvRwDCkyuinaT6SdmiBRTXBC8CHr1hLyT5Tc9ITlSH8q+YT4gn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxga+I6wtIb7oK7tKiTcrGVNvQEABK+AwE/D0nH21LA6/2tYZlt
	pi68f+JY4yFRaDeCmIkAbDGhP+szLmGqp5tfET+GRVqL5790+mj9T15ZICZAKZr2xSMRjHjHRVJ
	7pmbDW4vxxvmKjmI3AgFIjWycx3vmnbg=
X-Gm-Gg: AfdE7cl/Xa/QgX3VhCSbJuRhGsEOeAmMAQiDvLB5pU0I2qITUeieefbrdUxTtdt9Ua4
	MPIVQGs4DgkF28kXcQabm+RCGBVkG3DHCmWMkLFQGKlJKsokOcKMjyLEMXagI6UAX4kOx+RQeKW
	T/x5DwMLRUP6s9D36mt5X9I6B3xyUeDuSHqo0Ud0y4j+cNWtx76awd3xYzHqzR8rqwNZw8IAIkc
	+XgeGPf2NX/+qmRsj4JRhovD0O8mMnWAxOLngLPbT+kQ2shmI2bwWNT8MczaQnEGkgiTHWvApkz
	eeYgnMechddKCaBiFFtWaU4=
X-Received: by 2002:a17:907:fd15:b0:c12:79aa:8286 with SMTP id
 a640c23a62f3a-c15cdffcde6mr383973766b.21.1783611389879; Thu, 09 Jul 2026
 08:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624132356.516959-1-puranjay@kernel.org> <20260624132356.516959-7-puranjay@kernel.org>
 <ak-pI2CefDoz0D0M@localhost.localdomain>
In-Reply-To: <ak-pI2CefDoz0D0M@localhost.localdomain>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 9 Jul 2026 16:36:16 +0100
X-Gm-Features: AUfX_mwX0hxgcbp5_AnxAmomWbwd-9QdoQQfH0D1zAUoHWqOHyVS9SvP447iYb0
Message-ID: <CANk7y0j=TcK2tYhrmAf9dP0ab=1kzAu=gFasjU76ZFrW5xQ4mA@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] rcu: Enable RCU callbacks to benefit from
 expedited grace periods
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 2:59=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Le Wed, Jun 24, 2026 at 06:23:48AM -0700, Puranjay Mohan a =C3=A9crit :
> > Currently, RCU callbacks only track normal grace-period sequence
> > numbers.  This means callbacks must wait for normal grace periods to
> > complete even when expedited grace periods have already elapsed.
>
> The changelog still misses the reason for this change. I had to read
> the lwn article to understand that this matters under memory pressure
> in order to release objects faster.
>

I will update the commit message in the next version.

Thanks for your review.
