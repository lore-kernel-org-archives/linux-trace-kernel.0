Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8C7199FAD;
	Wed,  9 Oct 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482533; cv=none; b=lDCJVFBSFdQLWWrCU76LgIHlybHvEtkeJue7NTHNANy9w4SuDkWBQEzO+4AicTJrUNYteieoS+4sE75ZkxZT0KOTKO911dohA7W7NgaTd9M7TP2LWIC295rsJpEBNUDUdhYf5MKt5BaSjDl+hYuD5PfgxcN9sG1emDUWPDiqc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482533; c=relaxed/simple;
	bh=h3m4z6CvMibfnLPKSuhUW4y2ERcRckWqfbUIGewtTgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gko3qFIA7ySIKrtnRhTQDL3Nc7WfLuLU47kx2Wa3L38e8+FJmS3BEfkI2TQfn8S5MnoYQy3O9cCcFdTzSjz0BdLeyl1WSVpzr2jeGe1JyOL+VUiSa7ErTY35XCj+kvmrEwjUGmQ7whAsu8484YJL20j2/mLsyDh5fMlyhpclqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBio+YSL; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBio+YSL"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso97352331fa.1;
        Wed, 09 Oct 2024 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728482529; x=1729087329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fux8O+IPEy0HaEPq1LQWkC9rakbrNGkKReW143DXdkk=;
        b=jBio+YSLvW/v9ZcCaqGifActK68OxkMMWpOV97blu4joO2YwljZWEGHqVYgMqsjeIC
         MEQHdkKUIaGAhn9ZRGcPnUjeyQ2qQZt1wMjH8IZj1zNeQ/IOmzytsOIkEhk3Kzuqq7b/
         naLSpjCu/4C9+kDeJnFqscAJoaxF+BGDKFxgEDr+fTFEXMaimQAO4LVUZouaKN2hc+wM
         lPc7eqlu65lskFk/oPytT5NB91D4sff1w4TAolOPlCjCmbK9eEwUXtD+Sibe0CRFhalO
         JGCiatpB+D30GjbtyHb/vChmmYWQ/3esVjcrOy89dlPxg7IqYVWh4/W04atcRRJKQLti
         NyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482529; x=1729087329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fux8O+IPEy0HaEPq1LQWkC9rakbrNGkKReW143DXdkk=;
        b=BHxCPIMYRJepqe2XKZs7b73CqN0al1Bu2lFNItAEW5tL0kUyUlWBpwIhEpreCgCyHl
         /oa0SgQLPFGBUx9O7Ig6l8qm8zphQghSuky26OCtajE2EKBaanavFXK0axV4cpdOYh31
         ofINPcAcnPiZuqxLYjHjdzx3rS7Vxip9E2Rq00EiXG8AYm3LJ+dTACImMLJ7T6OGwg/Y
         AHc8hy8Ve9AgIn5t+3N3Xc09fGInq8JCJrGJP0hQWqPvstxs8e40u1sQK5Epx2009KOX
         u6dZ2cIYero3zD2nOv/LkkwsUJyQLuqqX0GBBCr6ItW8RahNrYwdl41GC/sIsnFw1z0A
         /6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHDbLxQT20S0l4Wq1IPSnIL/9WnZGsHYoQ4YIGK7ecF1ALIiXViUgWCOXwlrlM4vYl2bxXBNJJ1Sf+NW9OXndRdDJB@vger.kernel.org, AJvYcCWe5pMydatn9l1tcR402bp9nXsZngPQtW0j0bOKvW8iaW7sDfuvshSqFJi0r/34VXcFVw5Fpi3twvbeCCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/pI0UPYRxY3G/K7GBnyhN936IBzpyIkXnYB0q1pcj6WtdB07u
	J9pv4KhwrSZtK4u+n8mOINjg/m40AtfQJNyW1Xis2+bJ9aSQLBUtT4g+zpaFsEpMYqfOn725JUj
	wCpPtpXhPdOlK6J86NynqjKj1oX0=
X-Google-Smtp-Source: AGHT+IE2xJSoWcX/hyk+DBnCLkBl9b9V1fw1iJ7KcvOaLL+XUUaJziclV1ZQIqm1bRikHL11f0vIzGOn/47eie7GFP8=
X-Received: by 2002:a05:651c:547:b0:2f7:6653:8053 with SMTP id
 38308e7fff4ca-2fb1873d455mr23071641fa.18.1728482527487; Wed, 09 Oct 2024
 07:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009030340.16400-1-dolinux.peng@gmail.com> <20241009093727.4e99c1e2@gandalf.local.home>
In-Reply-To: <20241009093727.4e99c1e2@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 9 Oct 2024 22:01:51 +0800
Message-ID: <CAErzpms1mGeBw364qsX1YV_4=4sPhMhTRsWsjHZmH8Ro5xWoyQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] function_graph: Support recording and printing
 the function return address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 9:37=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed,  9 Oct 2024 11:03:40 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > From: Donglin Peng <pengdonglin@xiaomi.com>
> >
> > When using function_graph tracer to analyze the flow of kernel function
> > execution, it is often necessary to quickly locate the exact line of co=
de
> > where the call occurs. While this may be easy at times, it can be more
> > time-consuming when some functions are inlined or the flow is too long.
> >
> > This feature aims to simplify the process by recording the return addre=
ss
> > of traced funcions and printing it when outputing trace logs.
> >
> > To enhance human readability, the prefix 'ret=3D' is used for the kerne=
l return
> > value, while '<-' serves as the prefix for the return address in trace =
logs to
> > make it look more like the function tracer.
> >
> > A new trace option named 'funcgraph-retaddr' has been introduced, and t=
he
> > existing option 'sym-addr' can be used to control the format of the ret=
urn
> > address.
> >
>
> Is there a reason for the resend? I already have it in my for-next branch=
.

I'm sorry and I did not notice it.

>
> -- Steve
