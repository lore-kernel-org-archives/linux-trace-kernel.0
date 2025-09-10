Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2407224C077
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524024; cv=none; b=VH6kvpKIU/ktK/fnUpuh6dLb8GIDmsYKtBOHJlkfs7pSpoc1Z1tM63DAHOZ2qud15sevtfPnEjKJmh4VBf4N8HbKCa2TrR68NiQA8pgbjbwutXVOmiWDyYLfyCZrOFyRCF3SbY3lzdi5U+CS3S78r7gKGR2ib5jORe4Fx150o+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524024; c=relaxed/simple;
	bh=7De7/KamC02E2b5EHbxS6ATHgldlo+QByCWY9AZEpNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGjYg59owqi0EdYLq7s0avKd0JFrjiyGV4Em8pU0yZ8Zk5YY4P2zT26kuWu1fWsI9lxjYspsZuZxNcJTfQVVAwo1w5D4RDTHqeT4ZPtlMGuJNFSEzX2PZBNJzWGCNls0kHI9I3YpoROHih9YRIr/oizLuYA1pVl8WlJ+hqzcz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uspPnEsp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uspPnEsp"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so4558048f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757524021; x=1758128821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eW2e8p73Sm65C62B3d7xoYycH9WMEA7fbE5AMLTODfI=;
        b=uspPnEsp75Gdyr8PFtF7nwZCiUpV0Q80+b7q9ToT//k51OcBu7S7wJgfaE/28+pJ+p
         L+Ok0iM9VM/CTieCYeGz06ZvEbfqMTtfmdIMx4eCJI5l7JSuzkIPUvW1yvrL23MIawtH
         4O4yzzUREsV35mPm4nV50mfSJLyMX7E53OaQLODiVIECEQLhHIKkIQt3X+MfA8LKF8zX
         LIqVbZT05s6W+CS3q1rwWDRBOxpAH/upjbkn2bXXqvp+/sPDuT8Kf/8iK7nPT7sJ4sWX
         uaK2puq/4bXE0DiHGCwVF5hY4uPRfKC5BqhM/kuhkw4T2lprWEW6NKdnGkLRjr8SxccP
         QlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757524021; x=1758128821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW2e8p73Sm65C62B3d7xoYycH9WMEA7fbE5AMLTODfI=;
        b=DeJmcR9jOM3CLvbhPqUi2Nnwjcljn58FsHWhQnh2DKKo2qnvIyQB3PGf9dxbu+Qa0b
         s4czi4En5sbivo0FPMeQ5Elws0iUScvQ66mzivdK5JOqwLAyaDG8akGuTPYMqhu+Jbzz
         3PNDgRoDeMy4ma/UUDrmQov8dZ2qY+CnwNebCKesSbqYkPd42ozVQylCEJKwD0Jgz99H
         pMuwC8OcsCLUts54ZN6CXwcJvaG0MIG9+bTZS1D8kYwW2E4DcxBXJe+S/Lrr6FWwYYsb
         K6COBEYM9YJrCUbyh31yyv1z2j8FXIv3IlfSWcdz6Pk2I5YW1xC/dw+Jlo69MgYIXNKb
         U6Og==
X-Forwarded-Encrypted: i=1; AJvYcCWp/SR5ILA5cMAMkXsKS6o/iaxYdF2bijhpXYxmY5qHw6vPZAzS9811/83BUFj5GPCksGoQ8J8IZlZ7iCCTXvFhslU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QMD2nHPn5flYD2Pf9TwIdPw4oEQM02Gmj9Hb3eW6Id9UCJCv
	EKFUD2ChaJYm9Qr8SWGlmE3eR9WBasWKpfp8mdIlpJV5MYuc6r4/vPpFWbzE7Wt/SA==
X-Gm-Gg: ASbGncvBCSVqROAlqK9Cxc0Esilhst2Ovwa1r7dcFhK/jEvM+/aTqYMO1pk6ddWL1tf
	Z3uYjjk8h0B8BmaiQPX7zZt4EST+Cytx0Ya1FoWBOPlk0hsz6isNnsac1joNNeXQNFkmUBKc2Ru
	bgbRMbGCYxlzlOq8HMpksmVnbl1467Iby7TYJuGLOSqC+RmnNguUapEGXZKo7FE4vhSSNdBi9IT
	vjKxZdFiIGGj1pivfw1I6AKWgzFixHNuMcvuUi6Yyh2oHzSZ5LzIj8/FCZZF20hjRJTTtIxLWRy
	K/x6SO0+TCj8OYXoufROg+++buv5UXtATKHkzzOZAoR6rmEvjJsqC+fSTkQ+NRdQuA/8AVPk4oG
	a9GyF5btUBgFWtAnEZcv9MgtqZukQ5rxM7tFfymXUhqIzqhYM/DPpLrbR0HvvXfcFu9qJwyfsmW
	aBBtJB3kNADInrNGE=
X-Google-Smtp-Source: AGHT+IFpMY2LdotLVzenSyom37/MyUBFp2vGP8SWQXN5ZGAgsTxLPg9ujzG9esizRfQMqbIwV/AfZg==
X-Received: by 2002:a05:6000:2f87:b0:3e4:f194:2872 with SMTP id ffacd0b85a97d-3e64317ef24mr11131229f8f.31.1757524021156;
        Wed, 10 Sep 2025 10:07:01 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8247c3fsm34826185e9.11.2025.09.10.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 10:07:00 -0700 (PDT)
Date: Wed, 10 Sep 2025 18:06:57 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/24] KVM: arm64: Support unaligned fixmap in the
 pKVM hyp
Message-ID: <aMGwMQBwxRPPiCer@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-16-vdonnefort@google.com>
 <20250910124742.34185645@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910124742.34185645@gandalf.local.home>

On Wed, Sep 10, 2025 at 12:47:42PM -0400, Steven Rostedt wrote:
> 
> Would be nice if the arm KVM folks could review the second part of this
> patch series.
> 
> Vincent, I finished my review, and you can post a new version. But it would
> still be good to get some input from the architecture folks.

Thanks a lot for your time! 

