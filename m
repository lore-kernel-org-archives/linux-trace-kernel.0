Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3589E41D106
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663548; cv=none; b=gqcN0RU5FcAP7v2yykAkdQWeVU24mwhTqdeRGBAx6sYWpgeyXfL8Q7IfP32X1u/krKIO4Pk1b4QyXi81v7cRmdCdkAqJjSVh/iJi1YRQElDDOQdnl/zo1oV6AjT63uCxCQKsvF6X8Oda1FWPAbbeBl7j0jqZp87LHV+0MlEZ70U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663548; c=relaxed/simple;
	bh=Px5HaiRLFHtGk9GEgSeiRjA4kI4KfbcMyMMT/utFXMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdxYBGfzGZ/LobeDQrNeLwcSi7xZDr/MomBqyq7W32wi60SCuq0hfojrYY3yWV11hHRw6Gk4EF/f8dX3jQr923bgHV+30aztbdw6k8putjvJzjvv0xQsG8ggkY23z4o05s2YkuIWZZVOEV4Vr6CMHLDrBY+1xprQctGGCcO/C3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A5icUvDl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A5icUvDl"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c20ce3c118aso162877366b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787663542; x=1788268342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=twIWnBEJbxG0JtjIqNqVHRhF5vlWQ7QBPu16pn9OWWA=;
        b=A5icUvDl8cVYbS3wB9rMX+oQXhVYYi6D/clcs6h9sVqO9VnBqgeOoMft8E3M0cpbu3
         sigIo34DNkQ9l0TdGVwG6H+iv4Mk4SFIqc3O5p84iIXdobF0Pt7MUKIIOEXzTwKOWlcp
         ygcKredpDhPdnDZOShBDiGNUO7IVvATmQ44J3gBOb62eSZtXyZ2ajAKln0y20Hl6gyOw
         wDWaWM3kVh8djP6VLG/TD2W+CYGRWAk/4fak7v3QK0TE7p5oTqho/F0BI8bs7eFtAB7z
         Kavzv0RXvYaLMaDm0uxk5PiAnYrRPVxYWWgh3qcBj1jTFWtmt6fqbxwyZkvvuHxE0BUe
         k8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663542; x=1788268342;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twIWnBEJbxG0JtjIqNqVHRhF5vlWQ7QBPu16pn9OWWA=;
        b=s+tt+rXMpVe12/cs8AJ+3BFiZcBO2CrbLG9dmKrXXGBuFXUZs+AdYlqY6E/RWhM7sh
         aTeVwxiaoh5HICmexyvWWkbDqNpJ8aBfIbZcqDXlgR/rR7bGSqo4hnCB2icc46OaNCth
         B8iMdYZ8B3Phr9eZ+mUvOlPr8P8Ad8Ln1MjruHeSvEMlsbAH7c8DuAQxRRxEI8szIVLo
         MkjIFQnPNaSc9XwLYMAW/Sh+c346Ejbk31B/AowUyxlxtZ4vchuOyMPfJ9th51oiIXOG
         0JKoTieNDCHqdNr62+e4dhiPWWKOHVRA3u+zZOu4Qd7u6DclB7b4QQ1wU4MsBuTfT+bH
         KRxw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9xlLu9x3TPPTg5Zi9Nhk22+dYIMNP/LWpcWqyXI519ai+quGwDnQ6DOlxW56piqbsY3YxJRMursqWeMVuVH+CfyE=@vger.kernel.org
X-Gm-Message-State: AFuF++lgmbIbQ2wOy4BIcYPCpHOQkbK5XHWvEaGjqi3+s4Tx6QHgE5mO
	anlgrzv6ivv8Se8Ft/nIl5X8tBX0LpuQ26udWhsOkfMVDVZDWrfMNno4Vlt1rvYN1Uo=
X-Gm-Gg: AR+sD10HepMWXZGvf3L9zBIboXQOxbLaRfs7vJcNnZbtETkFCGGTjeVSgw6Do5q3xMc
	ShK//NoWE23BgsW7fmHUnd5cinm2O1Vb+RxctKpIi2B4qNVsiYJeOoU3fLqNNMuZmPLQdpknQ1h
	K53McVwy3BmDRl4Tnv+DV+ibki5zIKkJObWZQ5UgVxiWe50FdvRxeijsdd8049f+Uw4fMXhbj5U
	fCZc40TC9GDPujILnlq4d8zSDlflJVVlEETo9drikyz8QRAz9i8/nzWpTw63omfjJEDNEiGA7LT
	/MJRJq1we6hErq977e965Paf2BKNTlQ+MCUl9fXVISQtnhCK/wPoUQePKAZc99UiWmRANTn1Bup
	aDqW9z9CU9g3+Hsn2qmYUkqplBnsvcT0EpCHfSOD3tz4K7c6x9PMTEf9eW1ok2lhIAN9iTYUiG3
	Sa2NhD2iAPnsCuoYRWTfzZIZaz6PcNjnglsNIlO63RdIv6nCYR/ugPEZNV5hxD6d33c8VLY1sy
X-Received: by 2002:a17:906:5147:20b0:c25:58e:8d64 with SMTP id a640c23a62f3a-c25058e9f37mr109537166b.12.1787663542583;
        Tue, 25 Aug 2026 06:12:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496866c4csm1922258666b.54.2026.08.25.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 06:12:22 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:12:20 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz,
	jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org,
	joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net,
	stable@vger.kernel.org, linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
Message-ID: <ao2UtL6-HHTZ6trp@pathway.suse.cz>
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>

On Thu 2026-08-06 11:30:00, Andrey Grodzovsky wrote:
> kernel.ftrace_enabled=0 is now refused on kernels that deprecate the
> knob, so the old disable/reload flow no longer applies there. Probe
> for this with ftrace_disable_supported() and keep the full original
> scenario (disable, fail to load a livepatch, re-enable, load, confirm
> disable is refused while loaded) on kernels where it still works;
> otherwise just confirm the write is refused.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

It seems that this has already reached mainline.
Anyway, for record, it looks good and seems to work as expected:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
