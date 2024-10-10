Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7964E1CCEDF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581960; cv=none; b=kfPU02Uvu4JdGthZx0LgXiHwx2nbgKvBdqYLSz445cfOVKqz7+sMTXu9dnzjJU+YyIYMAExonMrOMxOCXyiP++C0fC1UIlFlqPChpLnCBFk+aZIyrr1Ny4OY7+Bq91TR0sRb9+cpd8hnk13MgyMnc/4HV3tIK29q3+OgacAZ5Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581960; c=relaxed/simple;
	bh=Np8QzsYabkUrhLeTsELlCeLTHqygJf1kkjkjTZEo5es=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RnU2ddOqAvkONAXw0JA7fHUrF/ubopBPTfoHQlr+uRzijW+LZlMjASjpueaWvgtc/IPFciHC+jdnEV0GKIRjOyGWC08Sn+qRK/p8Z/E9QDrNpD7FjHgJJQC+FUAY1WP+OKbv4Kc+D4L7XE2zGIV27FnCsD+nBBSivZ5PguvuyP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SoXBKuRR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoXBKuRR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728581957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oyXyYUaizqbaiHdQmCGuTHVEnPVLFmK7yd261DQHof4=;
	b=SoXBKuRRbLogkfrP4R2POC97hJE4r03AtmSOG8hsKRwJMenkeyWp/cLsRf0vRbvB5lLWPv
	+Sp1NJ4T1okMEtkg2mUYxJLVsfV1fvc4z7shh4zEZgkhdtxUlJGTWLE46e1ZZiQhe+aG//
	MWJXWEP2q+NioTgHH/oRDw2AeEpDRck=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-spequBRKPEapmICKUphwBg-1; Thu, 10 Oct 2024 13:39:16 -0400
X-MC-Unique: spequBRKPEapmICKUphwBg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6e28b624bfcso19454627b3.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728581955; x=1729186755;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyXyYUaizqbaiHdQmCGuTHVEnPVLFmK7yd261DQHof4=;
        b=RPLuna7PjrlLY4RobRHZV5vg0cSKoPw9RdnjmAuyOIJIRl7PoxCBy3lH5BlZ9O9uxF
         dm3EF/NYOeT55WSicwxCeKsSAiOtILsIvQqK8VjipnNOHjkHaWGEtcMNNM9fBnKzxxl5
         a6I/Q3+JjEKp1NzQXlLflcm/+swIdfK4awxjKkLT0joLAV4uygs50zugyJqPucDXaSfE
         bIVlb56rTicVloA1WdWA7TEfda0zfTLA1/hbv77LJo1hR3jdCMbjsXzSGDPlpl/q4gNb
         peU0a/litrlQ9n6WUlVuygUuJ4PmNvMcAfAHnyTXrZTbuKBIxRo+hUtPoVL09GUOy3eO
         8aqg==
X-Forwarded-Encrypted: i=1; AJvYcCURSGxfvZqTr/8eo0YY1vOvVirnviKL1OK0AZC1jZFSy/WdcdjCEj5dgZOGV5/e/NjguSk5DuYX/rljtHlbsUdmCKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsiJ0IwpjCxArZAKmbF3zcnf/cZhH6QISkNn+Dc+6A7Pvlra6G
	acH28/NciDN7WhB9D3ejgRgHAQP4x9EpoMYlOu9R8hXI+XYWclg4JNZ7FNaf9C8/JPk066lyl4A
	E4USkWYFb6cDRSbYORu7WwD/qtMHKOIeiu3Nm/1YOIHwd34pBvvkpJAEcn3xCcYSTZQB8N4GixX
	OHTg==
X-Received: by 2002:a05:690c:94:b0:6e3:b8f:59d1 with SMTP id 00721157ae682-6e3224d0af8mr60086037b3.31.1728581955566;
        Thu, 10 Oct 2024 10:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8aBE9VJkeXHMRogPEcBIWQ6lN2ik1TVE/v7vhFtFCpu94jsnvIVjehmWnPbzO3QVhS7jVdw==
X-Received: by 2002:a05:690c:94:b0:6e3:b8f:59d1 with SMTP id 00721157ae682-6e3224d0af8mr60085797b3.31.1728581955283;
        Thu, 10 Oct 2024 10:39:15 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b7751sm7356376d6.31.2024.10.10.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:39:14 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:39:13 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Ben Hutchings <benh@debian.org>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: tools/rtla: Fix installation from out-of-tree build
In-Reply-To: <ZudubuoU_JHjPZ7w@decadent.org.uk>
Message-ID: <5508e99b-f22e-ab01-61f0-4ae352e595d2@redhat.com>
References: <ZudubuoU_JHjPZ7w@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII



On Mon, 16 Sep 2024, Ben Hutchings wrote:

> rtla now supports out-of-tree builds, but installation fails as it
> still tries to install the rtla binary from the source tree.  Use the
> existing macro $(RTLA) to refer to the binary.
> 
> Fixes: 01474dc706ca ("tools/rtla: Use tools/build makefiles to build rtla")
> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
> --- a/tools/tracing/rtla/Makefile.rtla
> +++ b/tools/tracing/rtla/Makefile.rtla
> @@ -38,7 +38,7 @@ BINDIR		:= /usr/bin
>  .PHONY: install
>  install: doc_install
>  	@$(MKDIR) -p $(DESTDIR)$(BINDIR)
> -	$(call QUIET_INSTALL,rtla)$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
> +	$(call QUIET_INSTALL,rtla)$(INSTALL) $(RTLA) -m 755 $(DESTDIR)$(BINDIR)
>  	@$(STRIP) $(DESTDIR)$(BINDIR)/rtla
>  	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || $(RM) $(DESTDIR)$(BINDIR)/osnoise
>  	@$(LN) rtla $(DESTDIR)$(BINDIR)/osnoise
> 

Is Debian using out of tree builds Ben?
This is upstream already which is fine, but I remember Daniel telling me 
that he believed the distributions were no longer using out of tree builds
and he wanted to remove this capability in order to simplify the build 
system.

John Kacur

