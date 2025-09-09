Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891236124
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434483; cv=none; b=WQKxUqJEB0ppUVpQeb8uvMbAuHlwsrYrzctVpeb8r2UpMixycw/5r9iujGg074XWRSB2O7B+EDdUG48Ix32dHM+TrRU6KYBok1kb9VhPij0DLtCBZAGMwnEXwhB8SCleLaQ0JA1M591cVoUIHkQx0fU1gz2cbse4n1TkMDqojW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434483; c=relaxed/simple;
	bh=Mz5sKRsdSfgn13KUBdRg6Vvpk9EwU24uw45F0iw35JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eiuhp3piwrAM7LlXGty+VLIIPSvy+aSidn33lfR2prGJN+jee1CJxJ0SUltxU7Q+LtckoSSY+RMGGKsoy6Sg1z42TRbxjadgLsNYvy4hpfa/7frxh8p9Bf+/iuLjZiKrJjyTBwR7k8AEuYrsbJcPoONGwBT8GZte2T8M4xyCJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+Ig/RmQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+Ig/RmQ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e249a4d605so4675126f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757434480; x=1758039280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3MUxe5idS+BGR3j6o3LYiON4iTePZTn2nSk7Al8lT8=;
        b=3+Ig/RmQzXfUlRYvHiUY95vJ5X6M0CfS7015vFlA5Kgt4WBKEInYBbC6T0DiVjKdt2
         as38KcjOcFOloJJr7oXfoJCVfvDs4m0BTxZACUlXdpGkWxaL6/XHSPcWpIv5NWR0e775
         NCh6ISuFaDfEGPzimgfiaFDVDGqiIVQSXNbsHq1A1W3TGQyyUPe8kiwHv+weP2sfu6t4
         zWlnYADi4gXEVZSM2YpNg0Kr7qvo6t6GlJX1zH9x0J+qIbDGHlQ6/ol3IY1aAK+Vf2U6
         vgfemXbHdO8hcwWS+kkZ01Mauo1IHkiHuQD3Vbomtm3J49bHn1cD59UbTsOgPyHnjLVX
         6m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757434480; x=1758039280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3MUxe5idS+BGR3j6o3LYiON4iTePZTn2nSk7Al8lT8=;
        b=tPV9ibkmH8xD/t6wa3OXnFi28GpRXpbZL/H3QOn8eO5+ay57T91ip+hQPFW6jA7uIz
         tarJLtCdzcyiaITRm9gVb+UNd3GcP/R6GvRtiPYYi4MuZg6S7PptNFl/nvXSJ68BDG8C
         JGOZsxHI6Rtb9Ko1wkcEKYIvhYHqOCvZZ2FLGCg2c9jGV+8uDuCMxbwtcpVErZ1rpJ7p
         8QEv/s7WYu+l9zNk5x+avWPXTvREIR2QARmyd9cdGC+EsuS0w3trs5yjYPOAirST9NVw
         ot1bjd+Kmo2Hq9CB/PYq0KH7qxNwSQGlCdXpDBuEQ/FV+/5RS1aJz3p2bGyRGuVRkO5V
         sLBg==
X-Forwarded-Encrypted: i=1; AJvYcCVtPUvbNgPGa+8ianzG1efLiwAC6wUUM2nznaiK6knQgzGDHjEMHTRsj210dDp/sx0n30s7okj3VDZwFLMZ/jq0UkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Usb8wnCsHbs2FcBCBqWcgHdY8Q6PiVO18qVmUH/E0CVXsH3L
	+m6Hx3ew4OKsrBmBwo3ZeVk/0Ge/sHj284N/RqQwKDHom23b75gyUmXoCgbmoC5zcw==
X-Gm-Gg: ASbGncu9X3zx0cLjM//AgxZCuAXPsblpnSePfbEYItpESEtJzXh1iLvrasidB5yPFPG
	uzArS0ME66/grOQ6BJmFJwGaPxctnuahK9o9qCsioAEKA1O3g+e9G/Rtso7yoOjxPl96sswloAY
	DZzzVBV9JHr2i9fwJBCBDW0uIq6I6sTHGO2N2pxpMOff11IbtRlJFTGNYOm0sSsR3oP+q9IGICT
	fQeVP8KJU7YCY4gSxLosvhBVhz3GMoM5XgjOYnjvvwn31R33YS1u0bXoxTQUOYy30CBBADM8P/v
	93hSopDZO76+6QdFfm/ZnGWVXuqb2YtfngrmJceVYxufZqqWPgmm8vizPTdf3OVlFFzqzdfMIgK
	M5HR0hsERqyQq2bAfBjhBGgNJj6/T4R6IO/bUIn7da4Rz3AQbbBqf2x5M7FxaILc41yBGUtqbrA
	ORLssJ
X-Google-Smtp-Source: AGHT+IGptLchfw5sfmOjEPtY8r2qXSKc2v7A8C2EV7ihJJOKFikE7Xpor1boUUPU/n3AR1zmFBHKUQ==
X-Received: by 2002:a05:6000:248a:b0:3e4:f194:2887 with SMTP id ffacd0b85a97d-3e6462583c1mr8562991f8f.30.1757434479398;
        Tue, 09 Sep 2025 09:14:39 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9a2esm3528836f8f.14.2025.09.09.09.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:14:38 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:14:35 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/24] tracing: Add reset to trace remotes
Message-ID: <aMBSa29ev0BNgr5R@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-5-vdonnefort@google.com>
 <20250908193757.079aae76@gandalf.local.home>
 <aMAZMaZJ1_Eny5Ku@google.com>
 <20250909094028.3265b751@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909094028.3265b751@gandalf.local.home>

On Tue, Sep 09, 2025 at 09:40:28AM -0400, Steven Rostedt wrote:
> On Tue, 9 Sep 2025 13:10:25 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > I wonder if we should name the file "reset" to not be confusing to users
> > > when they cat the file and it doesn't produce any output.  
> > 
> > My idea was to keep the exact same interface as the rest of the tracing. I could
> > keep that /trace file for compatibility and add /reset?
> > 
> > "cat trace" could also just returns a text like *** not supported *** ?
> 
> If it's never going to be supported, I rather not add it. It not being
> there is a sure way of knowing it's not supported. Just adding it because
> the normal system has it is actually worse if it doesn't behave the same.

If later we extend the meta-page to support non-consuming read, /trace would
then become useful.

Another argument for non-consuming read would be to enable dump on panic.

But I understand your point, it might be wishful thinking at this point.

> 
> -- Steve
