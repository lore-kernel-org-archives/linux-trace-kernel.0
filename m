Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE838C411
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351014; cv=none; b=fxiWOdlZGXQWTM75iETOAtgR1GWwJ6Twd50Au/ljzUWKGxjV5JXo4L8W1k+3qaRQFuHtVgCmgG8N1lFeJTjkAUOT0KE06EUKBS7GyfgN7AufDIDzjYjNuCFpxBnEVJGK9CsEvdMEMgNdVBS2rI8t271bT+XRgpkBNCcVlwb7UkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351014; c=relaxed/simple;
	bh=AbdZJ/laEKTWH0Mal+6Mop2zV3UXcKdo43MTEhnAjxY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=utGq3Yx93G9+BfYPMRKAlTMsxPPVctdJJqIj8NMNipfgdSvDOTeppYeFVjZQCu4cjdW5rrGDYt0mSYL28y+/zaDsFtfnwVQ/hDamC6qSIcUR4cvRl2tNQehBaxeW13z3J1UWtqIROWvTPerhNGrnNKlarB/OFkvisPGE+HROkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jF3HBsLi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF3HBsLi"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so1632885f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773351011; x=1773955811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbdZJ/laEKTWH0Mal+6Mop2zV3UXcKdo43MTEhnAjxY=;
        b=jF3HBsLiHjba7h1QNcVmxTHVWR+TKdYK4AQ6LFSIYT3299ha1GY/7wjsmEMnkAQoNQ
         49g22LnWdbJ/kDrt1hpFq7V7sMOWVChOi84/PUliApPChcPzHe/geoG9oAxrJ4hpqvh4
         QOt4/jgognHDlckdNBaPPAAEGIK+ShLPuTyB0A6NQ1GbHA26OQ3Jlh7rLGlQWWaeX4+G
         FFIbGdS/cIhuk+yOFaP/6W6iZsW47cHkQi2MANr3y9uavai42JlGBgXMz1jTUaFvnkeD
         NzYSqrXswI+x4y1MNFrEu2dpnWDJ0QMfT/vkxZ2AwscAmoNRbLIqBCxrby3kC65hJPt9
         eIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773351011; x=1773955811;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbdZJ/laEKTWH0Mal+6Mop2zV3UXcKdo43MTEhnAjxY=;
        b=IMMZUIwsh4fQiKpFYQaKQwPwmEgf9hmyHorCc1VtZr6yfEaAHguLk9dSe9TFU28ly9
         oJpxNzgDjv4VAuwkNV16X+ZSNcuKrrSpcYUdLCuk/klbWcNk7oN/zBjbiZQPZ/qzOoA9
         VRjlVMuRXZvugmclwSFO9zZTSAJt7YApRq9iWUEhW+N63yT69VoJxafYfA1AeEFlEK/3
         V3y2s0d4xDIXMjxMQeMbLlLA+yB5MSPYY2U2+Ozlmf1zswLpblNSjEAS0h9egW9/HnNg
         sdkUchwXr6th9ldOQXaqCj5+Wq5VNhoLHSL9negOeC+IC1abxOsJqSVQc7o1lye/RYdx
         Pz2w==
X-Forwarded-Encrypted: i=1; AJvYcCWFR25NK7DCYN4uqgQsqPqba9qC2hfMvDrvNZ2sQnP1fu5o5RhHx7EjBc9+CGZxIUeTZTZ69X6ioccS0WuY4xubivU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygKJJtur+gJ/KjY5RFhhWC+C525S5BIe7Bted6/5vCd6NUra3J
	FrelmO/OW46Pmm+PLwdWgMnWUA5LPpowGLZSY51x2yZdPKNkyx6dDhDK81AecGHCD5k=
X-Gm-Gg: ATEYQzxIsNCGUa0EZmMHG0JDLhrmb0e+VGxv8XWWyAMHYLEgLv9PJ0txpvtwgwcsqvq
	enHte37cXO3kgYnjOsnCu907KzMHzhruSwOEj1e+a5E9OW56CHuFPCYqojG3qbclZ9+2nRbUkfk
	pJ9t+ZF5GStqYxrPBMRnj5xS9kJfSbzy7dCSrgmuTW6DejaMum1S3K2zdp9iX30rVN2DnJUtq88
	YcsTJ8OtRWM8x2azbh6XH0KFJKbKYsWqHp9z6Iv6j9XiHAMA2svaarGOa9XJhJtZwp4J0LZAiea
	i2ICDuPZwupMT9NQkPNR43AyY8SEyhIgAC3kZ9cNuK5pfYqRl7xH6ZlM0zxX2zq/l8QkGMnqtX1
	z/dWk1yFABgHPCnooPedlHVPWyVyOWBUIplxi2l5A9fMTGxxMMkJB7bIIu7o0IM9HPs1wncBuOr
	yDut8dYL1W3G3brMYr
X-Received: by 2002:a05:6000:26c6:b0:439:cd26:ce0c with SMTP id ffacd0b85a97d-43a04d8669cmr2523513f8f.17.1773351011276;
        Thu, 12 Mar 2026 14:30:11 -0700 (PDT)
Received: from [127.0.0.1] ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm13757033f8f.27.2026.03.12.14.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 14:30:10 -0700 (PDT)
Date: Thu, 12 Mar 2026 21:30:10 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Law <objecting@objecting.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Message-ID: <1bd0e36d-0ea0-4a79-bbee-e38de553f1ea@gmail.com>
In-Reply-To: <20260312142809.cb92d6b5197e89645edab80b@linux-foundation.org>
References: <20260312191143.28719-1-objecting@objecting.org> <20260312191143.28719-3-objecting@objecting.org> <20260312170643.4b0f926b@gandalf.local.home> <143ca1aa-d053-4947-9817-72462876c224@gmail.com> <4c426803-91f8-48fc-ae8e-20676479b370@gmail.com> <20260312142809.cb92d6b5197e89645edab80b@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/bootconfig: check bounds before writing in
 __xbc_open_brace()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <1bd0e36d-0ea0-4a79-bbee-e38de553f1ea@gmail.com>

12 Mar 2026 21:28:11 Andrew Morton <akpm@linux-foundation.org>:

> On Thu, 12 Mar 2026 21:09:52 +0000 Josh Law <hlcj1234567@gmail.com> wrote:
>
>>> That's a fair point, Steve. Given that brace_index isn't touched elsewhere and the current check effectively prevents the overflow, I agree this isn't strictly necessary. I'll drop this patch and stick with the fix for the off-by-one reporting error instead. Thanks for the feedback!
>>
>> Wait Steve,
>> Thanks for the look. I see your point that it's currently redundant given the call patterns. It looks like Andrew has already merged this into the -mm tree, likely as a 'belt-and-suspenders' safety measure. I'll keep your feedback in mind for future cleanup, but I'm glad we got the other off-by-one fix in as well!
>
> Please wordwrap the emails.
>
>> And in my opinion, merging it is a decent idea.
>
> You've changed your position without explaining why?

Sorry, I think it should be merged because it's better to be safe than sorry, I know there is different methods of implementation, but this one still works... I know it's churn (and I'm sorry)
