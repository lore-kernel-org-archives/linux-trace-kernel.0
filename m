Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC32F1684A4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Nov 2025 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336619; cv=none; b=ZhUgnQ9IW+E4M+//jMVwoFcbAjWk1Gr1Hkw9cctRBJ9Q9R5tpeoTFNO8zg8TQtW+dEBzfZYm3HXIYdNcufA1PkgY34GMhaDKb28CCtceTgFluET3Sa7iTzGqgSvd3OUs8xGVTNc6RGH3nmoNMFtHFBU6dqqvBJL1qWK4JJoioVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336619; c=relaxed/simple;
	bh=r7FouT1x2dRUs6nM6oG0TeKmKc+zDhX8H6XwS8+nAwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlMpAbWMByw1UMR6HkPExcFwW3pZLlHqrotstQZFweHxdDpHOwibmMdaceAogdX6jpkZJQ70y9zXAshDgry9lGo+hJcx/FBqA3DK7LJYRoF2UaOKDHLbQyX0KtvRYwMBzW/wTI/Uw+LU9Z8STSd9Uy8DbVqnuqjmESmFHyelinQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=de0Bh3ga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="de0Bh3ga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764336614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r7FouT1x2dRUs6nM6oG0TeKmKc+zDhX8H6XwS8+nAwQ=;
	b=de0Bh3ga846stEZoABwj7OelwkR4GZDujdfx+7PBSpwi+DLoWRjWgsh86r5GQ04ioANWgj
	crcOlbU7Ne0v1G9Yn3sVGp9pLYkjEIoDamH6ylDnWYQwlhJfp+JPEOLh5MRbInfEf18Vae
	+2zx55b17ZZFxTyz5RAMw8EmmEO0eew=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-dVrSWFDwMC6NIe6P7CjYAQ-1; Fri, 28 Nov 2025 08:30:12 -0500
X-MC-Unique: dVrSWFDwMC6NIe6P7CjYAQ-1
X-Mimecast-MFC-AGG-ID: dVrSWFDwMC6NIe6P7CjYAQ_1764336611
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b726a3c3214so135602666b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Nov 2025 05:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764336611; x=1764941411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7FouT1x2dRUs6nM6oG0TeKmKc+zDhX8H6XwS8+nAwQ=;
        b=TeOeKo/oe34ed7IbYmn7kC1c8uSFZm29uBVHbJOEYAMURIviF7hhzvC8vTSF6ONQcs
         5ycth+c5qf43UGw8dmH/MTUOeXrm2nWe12qGvEx+E+/Sr7Jy36757dYbKMDcgOL7pg1x
         pBvJUBlTN0y5Y2Cr1lI869tDOGpTIxHPqQ+VWXRg+PbySWiCGMJl1WEiUud4XRU25leL
         C24VphU1Kv014pLO3oTUgdBxTmdEif2wJAd7TFF16PtZ8JrkxnUgbO5ftkt1aYiNLONo
         Skd+a18jNpAvDBg1RUcATz3aAYgBYjnWaSUG//DEWijmAJQEqMfnXYxiL7VobZdlybn5
         Wm4A==
X-Forwarded-Encrypted: i=1; AJvYcCVA9IHFfmxCcXZq6iAD6jv8wKTeNFB6H3VlZpQwQx2XhjEc6gzs0ntX34Ujg+55pOVvQC+zDbvwmWvfQUk2bNdTCPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPanA0EMyAw4B3I9jCiMvEAxs5imdDaejIknbcSsgfVmgv/4MJ
	El0lWGR19PeUKLbOPP1XMJEQzZ7JRR5A7jL8Bad1nAwbM2WALPaio5ciRAP6NBfuQclXqFLGY5I
	3zuROf5l2glMcZl1uoL2XC+R4rQGjdKWTn6NJ8hyG4z46PRoyaecP8KAda9JI5hRXUn8qm9KWRL
	kVjeZiepFMIb1cBSadtwX2f6ZXEOo7vzCe9kEU7kTi5BhJgeB7
X-Gm-Gg: ASbGncv5TQrqjVfHqZqNO7Luxck8tr2/URojIZZiwjbBNtLPXeUg1Gmd/CUdtDdzsGS
	4Srz8d+LAqar3RvBL4UM16xWnIXXNoovV5iM6m55V0d/xLtf6CiQN6XP34PE4+IbqkJJPfzDK4W
	noV/fXlb0C4Mht5cAiME2aD0iUdaOhiIu0RgkK9k+j8v2gRMoEg+jiDYJnQqDVB+GtHLwKLwVWc
	890MFNu1WnXVzRoQS14KmOh86kR
X-Received: by 2002:a17:907:3f9c:b0:b6d:5bc3:e158 with SMTP id a640c23a62f3a-b76715abd36mr3024374966b.17.1764336611315;
        Fri, 28 Nov 2025 05:30:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQBMc+jdR6VKe7qvu+OoNY3CTuO3aeqFl+E2pE3HNfuJdzO5dLePN/skocMuCUXp+HXT3tyPTBQ5sE12XnkZc=
X-Received: by 2002:a17:907:3f9c:b0:b6d:5bc3:e158 with SMTP id
 a640c23a62f3a-b76715abd36mr3024371466b.17.1764336610818; Fri, 28 Nov 2025
 05:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-2-wander@redhat.com>
In-Reply-To: <20251117184409.42831-2-wander@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Fri, 28 Nov 2025 15:29:34 +0200
X-Gm-Features: AWmQ_bke2XaKTo8AW04BHiRxXmDpA26pbLYoxGuxq-b6dvmBNgbC2XPMHD4669I
Message-ID: <CADDUTFwK=TuhMcfr9C4NXOEQc89wBvdZtv+DtYFuHfc9wh5R=A@mail.gmail.com>
Subject: Re: [rtla 01/13] rtla: Check for memory allocation failures
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pwvuwYt9FVPZmVg6_eD6jw1cpjULq_7u2fblNLfx-Rw_1764336611
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Nov 2025 at 20:54, Wander Lairson Costa <wander@redhat.com> wrote:
> Add checks for the return value of memory allocation functions
> and return an error in case of failure. Update the callers to
> handle the error properly.

Would you like to consider using fatal("Out of memory") instead of
returning an error code?
Anyway there is no work around for out of memory.

Costa

