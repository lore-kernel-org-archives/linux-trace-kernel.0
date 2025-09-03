Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746EB362995;
	Wed,  3 Sep 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923907; cv=none; b=UTBfY/jhAyxn9VNzsBSiR8h4UEcB6W/uoyyoSrmR0IdUxJSQwiouFKxs+V5WU2wFzCnqi+EyPVZ/iXxV7t38R8D8IVG5WqgfNs8o9pVe7JpVVOgIXBP/rSUtbqntmBXftDUnfe7ou5BNYxxVhPLqnNJhG9VIDuJCOA31fidPZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923907; c=relaxed/simple;
	bh=8gpc6kMrndw4M962Y7S8ceJAWleQhacld4rPxwaAuGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFJ588Uj1ieHNqPN8K50jsUhetlVC220GknsVDAe/F9TAN6iRji5U/C/i5tuvUxaD2V0tMtWZ4F4evdOoEFT5wUu4Ccw+UFKfHSOOgZNnBfKPZCWDDzSVTscy/es8n5n9zFkTmSZpBfb7hL1eGODDAW2/93FBdHtJO7vSP6oR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awNAjDPr; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awNAjDPr"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7240eb21ccaso8496806d6.0;
        Wed, 03 Sep 2025 11:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756923905; x=1757528705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTc0pjUarCBmBq2VGRCMBpe3VbsyG/A//yTqfRbCJ/E=;
        b=awNAjDPreDdLAEq5k4HLBj7aKONyraa7P0yA87JYQg1Orj9zzNCyRP6IikUlh7Lcaf
         wErU4OiwIR/j/Ni73iiR5LqpOHXx7jNsiTu1MInm4Nx6MJUhrZnjHbXXnObFHQeRzplF
         KvhVWaBQijvwlVdGwXYxxzZe8zNZ4iaNcZer+rDQnu8RlxAYkWkaWAYf39OIlZezubTb
         v8T5az/hBgo2MysRiSi66UMHcYxMnIP7ucKduc8a55N/k244ybNj1Viag/3UNMtenS6Q
         jAiHA7peM3mkZv+nBJFBeTTh+837oVTchWgVCXQkh0egGiiSe+Wgip33qUNBPeg3muLz
         DdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756923905; x=1757528705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTc0pjUarCBmBq2VGRCMBpe3VbsyG/A//yTqfRbCJ/E=;
        b=WdawUPUYmDUKbu8DxrDb2OnNG9C+BQj+tzk5fWhAjtcimxUnCNAuOMGk0fD9PbkC/V
         YrdK01LGFZmsLLs0W93RPTFis7oSp0GGYIDAryfod6N3N0AaUjk4ld7+GE/h2/bRVW0l
         GKPVrByswAn4P7l1JlcI4VFsAX7UMVFEaMSY6OnHdUL81QLZAzAJysLkgd8Ztue9RfRs
         S+hxiZzkwDxSNYFXmLxxE8iU1KiG8NHXrd5nSmIRBy7kdfSUF25pi+9hGYVpZDQ0bUPR
         /YV2uVKeyBftNHoaZ7OiroKA0BFdB8R4RmB7oGNDsNkHwLuxC6E7O7BvH73Xh4v4I4rs
         XHTg==
X-Forwarded-Encrypted: i=1; AJvYcCV7gDoBSe+h85uiv0iltIAngP05I7Gt8tUhHlNjzjtbwLKsF/Ywl8MGYBSpbG41gtb7TzlyB5xL7cdtgb5fcIA5Nfb5@vger.kernel.org, AJvYcCVIYpbO+m/JHrMgBm+6DgRHT7cEZ+hj9tkBSfL34uKnQlV2Yeiv6YHaePAnPeV9UgoYEf7kKzViP+M=@vger.kernel.org, AJvYcCVjndEwgLOHkZGyMl5yA3dEZT1SA5UI8bdNyIy/1PUj3dq59u3OOwnGo591nTXDBcZajzL41jQccZvKwpSz@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2ukD4ZrA+61lP2x4bXqD5B7r3TCMhQ0zcxcMTWnE/lJW4AeC
	siJyYVurx04hPGBcHGSED23DacAksVIYiv//M0ap4QUa+YCDSI8RwpLvsniVHkik2XKasg==
X-Gm-Gg: ASbGncurOZMaYp8FTvgTAo1VzrEcvXF5bA+4275e0xh1X/IeycV5KLjQeynUpyGX0Ap
	wVazR25nse82akZ+D89ubbHaUAM9Xl23GK0dyRB2eTMzCxk5HFjE9LsZYCwoHjHHlf8EiOb9BTV
	kJUC9x/QUmIoxNev+9MoQOMVTcz2Jg+R66kA3lponJZHdCoZU/cDBevs9gl/YUPI3HwFOPfULqI
	o4jwCsH7q+JuxUcICg3W9mXCCVyYdflY71mg8KhTunQzf4UwMgL9Tq1SeBeqhC6hFlK8KDvxYYq
	45afVs8RI0P+YbKDqMbN2dLJtm3BS3yKbKSCfUwdnOxaXQtFdMKAqY+vEOeWTaGxgk6eJq/GZC4
	Cdc0ufkg6pHURWLD/rpbFNayc45h/an1CsKP3xHSv0wJ9+LEG
X-Google-Smtp-Source: AGHT+IEzPCnSFDIIko5XzIhlnGQnV76vwv0dzGHaNdjyAS1E5bTbpFLSmiESIEyJ/zMJNHrSMtBPcw==
X-Received: by 2002:a05:6214:611c:b0:710:52a1:d0f4 with SMTP id 6a1803df08f44-71052a1d49fmr162605276d6.14.1756923905240;
        Wed, 03 Sep 2025 11:25:05 -0700 (PDT)
Received: from gmail.com (wlc3.cooper.edu. [199.98.16.8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b683283csm32651166d6.68.2025.09.03.11.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:25:04 -0700 (PDT)
Date: Thu, 4 Sep 2025 03:25:03 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] trace: minor documentation fixes for clarity and
Message-ID: <aLiH_zWPOsjMRs9V@gmail.com>
References: <20250831101736.11519-1-seokwoo.chung130@gmail.com>
 <20250902102831.134a26c1@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902102831.134a26c1@batman.local.home>

On Tue, Sep 02, 2025 at 10:28:31AM -0400, Steven Rostedt wrote:
> On Sun, 31 Aug 2025 19:17:27 +0900
> Ryan Chung <seokwoo.chung130@gmail.com> wrote:
> 
> > Resend: fixed recipients; no changes
> > 
> > Hi all,
> > 
> > This short series cleans up two small wording issues in the tracing docs to
> > improve readability. There are no functional changes.
> > 
> > Ryan Chung (2):
> >   trace: rephrase for clearer documentation
> >   trace: fix grammar error in debugging.rst
> > 
> >  Documentation/trace/boottime-trace.rst | 2 +-
> >  Documentation/trace/debugging.rst      | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> The only comments I would make is the subject tag for the trace files
> is actually "tracing:" and not "trace:".
> 
> Also, even though the changes are minor, a simple change log would
> still be nice.
> 
> -- Steve

Hi. Thank you for your comment. 
I will make sure to add the change log next time.
Please let me know if I should do it and make a v2. 

Best regards,
Ryan Chung
