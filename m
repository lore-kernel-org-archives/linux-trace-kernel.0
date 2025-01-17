Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C4F1F63DB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 05:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737090498; cv=none; b=q/WCBZGUjM8Dta7RA+RY9IMFhhs0RgvCnjFCDwPgzLiEAC1W9Us4/NGyK1gUSjRWKAi5RsNL92xIa4rBnJyRkLB0FOKXQx/tcmrCNy94YR0JOu0rFJ+s2TCJVohsP46F6NZTULf7UxkJJVlzlwmi/nAvtYHeQhiSq+i69Ykx4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737090498; c=relaxed/simple;
	bh=n46p1I2zGdJqlRmcdLauRrquMFZUxRJodDoS2Wk/cnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KviT+YUXOgQZHc0k17YC93uB5jo9Zlk1JC0CApePKOqyz8fccvP6D4zIzbegU0l0ioSiBHJPlmdZuVBSbhw4PM2DkBVK+1gDP+whqglBspmEfA6oAFONjbfjBPw3tZHsyOpTys3EkUkbsPi/pnORFZZ3bS/aBNB8P5s/0iAryZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m672Zxnr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m672Zxnr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso10755405e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 21:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737090494; x=1737695294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eujaH9TaJbnjVBMtyQlKAWDn4xa179ZR19x+bFJDdEk=;
        b=m672ZxnrlaHV3iiF0TuSf6i7LgSImuuFuqQlTewRNCpk5QDMvTL/1wjXV531OYBGAe
         pP/8zqQMbhgLyIKilrPbzBo0s7JJ0yRSzEKjenw6lePMdpVRpygUXpgE14iYqvn07NFi
         jqoxKINji1wGlMhMK3DEBLnxPHDJdgCWlI0iL3dVLexmHBCEU0tSk92HwmSHWBOO4bDD
         W4ilUJlN8Gflbbuo2YrjNmfULfwbEYkU5muCbjqCCWp41BSos8CqIopE/J4qQqNTORyw
         C/7OgA/X0KFjzjJ3Z8v9Ox5/7G7mkfbN44+Hhp1Mggwg2thevHIh4eFXKZN8WMG+csuA
         m6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737090494; x=1737695294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eujaH9TaJbnjVBMtyQlKAWDn4xa179ZR19x+bFJDdEk=;
        b=Zzz5aZNpi6cTWIjrKcl1GqeT6G2CtTWqcE2+CHgtVEKtqdyRzdxqY25KFa61SMF1fg
         EomW/02VppyMkK/IQCJfcJp5HcaP1mg5p3CXMPYQkw6aZ7eGc4ZEhDlt3DMsH05Y0ncd
         HkJEAdgDEXIxerW7pkOP2oVDsW/SIhjfiqB/kqCjfLLLWiyXqk6jxED3L+Z4t7AzOKiL
         TrYi2whnrgLo+YHBokTmNN3M4JDZYtJPWCObAXbEV/RUKiFFOBFL7mxYzgnuLA/mMRjb
         9bQwpu315rQEoqYTt0Lhl52ffLTryW1d7krylNtb/ep3ZMO48xMyQNaQnLug7HiVAH+E
         4Q/g==
X-Forwarded-Encrypted: i=1; AJvYcCVaPgDycqz7kHcmz7+ZS9oK8lxBhzqMwgAaz2BDHYtquz2QzOvkCsGh+pszT4V21S0qPSI0ulRxaA14OpgxzDDOrQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSN3lRZPhQjEb+cLpxF4h4/DHFz0wXtSwYocoC7cLEzKX4r8lu
	3QcWUJtnZ4foNGjOd3T0lNmcwnP35G1GUfVc32vTCg3e3IHkFYcuJIVfE4Lfivc=
X-Gm-Gg: ASbGncsRufPtwc1ABVd+MtTVft+RDiy3pq1B7/o56KP+Je+lxtIPlFtfIpBvYSIsN91
	hZ8mG5pI9imvHq596Rw0fgYDckfK4cPNeMoH6gxOK9wq7hij3Ar6omGFcSJGRnEagJqWyUGZhGl
	T2FtxfMjGJuUXGJmf2VpHmjS0Mt4+9FJ02+guTZOriOzFc49zOsGXTsFe7R2K+5PLzcnfwNxkkh
	uShHPekfDbMxU0M+EVB1fS3IEmqq5OicmvurFcwOHP9tTE7rfqAmhkEVTo8ow==
X-Google-Smtp-Source: AGHT+IHllMRes8QADHP3xRRzfM0TQxggjj9PY2lflO/adJfq4rL5IpsLrXZE7CCVQomE7PJCMMbvdA==
X-Received: by 2002:adf:e905:0:b0:385:f0dc:c9fd with SMTP id ffacd0b85a97d-38bf5673c35mr707737f8f.27.1737090494197;
        Thu, 16 Jan 2025 21:08:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327df12sm1492547f8f.92.2025.01.16.21.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 21:08:13 -0800 (PST)
Date: Fri, 17 Jan 2025 08:08:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tools/rtla: Add osnoise_trace_is_off()
Message-ID: <435c4d70-3a7a-41d2-b49a-9de7cdb77c14@stanley.mountain>
References: <20250115180055.2136815-1-costa.shul@redhat.com>
 <099e9ae9-5d36-46bb-8790-1b6a33dc1448@stanley.mountain>
 <20250116193432.716db3a2@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116193432.716db3a2@gandalf.local.home>

On Thu, Jan 16, 2025 at 07:34:32PM -0500, Steven Rostedt wrote:
> On Wed, 15 Jan 2025 21:40:40 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > On Wed, Jan 15, 2025 at 07:58:30PM +0200, Costa Shulyupin wrote:
> > > The original code accidentally works because offset of
> > > `record->trace` is zero.  
> > 
> > It doesn't "accidentally work".  The people who write this kind of
> > code 100% understand what they are doing.  They don't see it as
> > anything complicated.
> 
> I'm taking this patch but I replaced the change log with the following text:
> 
>     tools/rtla: Add osnoise_trace_is_off()
>     
>     All of the users of trace_is_off() passes in &record->trace as the second
>     parameter, where record is a pointer to a struct osnoise_tool. This record
>     could be NULL and there is a hidden dependency that the trace field is the
>     first field to allow &record->trace to work with a NULL record pointer.
>     
>     In order to make this code a bit more robust, as record shouldn't be
>     dereferenced if it is NULL, even if the code does work, create a new
>     function called osnoise_trace_is_off() that takes the pointer to a
>     struct osnoise_tool as its second parameter. This way it can properly test
>     if it is NULL before it dereferences it.
>     
>     The old function trace_is_off() is removed and the function
>     osnoise_trace_is_off() is added into osnoise.c which is what the
>     struct osnoise_tool is associated with.

Thanks!

regards,
dan carpenter

