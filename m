Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1143C7BC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240774; cv=none; b=rzhJfVk+HO2z/G6e5bIpQW41tXtcZTbcqydHGHimusf+9Ixk2zUCpHAvAtLr4tyIKZTVdB4N+6KYUrNvYaieRpH7ndqz7PBWeYFACx4pVdtWIISAC0KwBMVtopzTFuf4UKWNXxvyBPa5rtvuJi2zDpF4Lng2A/L/Jp/uSmQJPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240774; c=relaxed/simple;
	bh=ok/KGrVby5oCPw7YHj3CExTD4NS8xQvn2lFiwSDUAFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwolmudfoFsOqnZS7JIQHfPWBJbgGsmWxsuDokF5jlw0EA7UqWe6jtOuMc+U65OlZWIp6GBdgX4FOmCRoX2bRNEbD3gqsHqIqMLqhoPnFOAGeHs5NinFNt8YxT9zFBNKgyeZeCtHd7xRP5lFlA3cT6UIyF5x2NPzd4PuSQHQis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NkPbC4rP; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NkPbC4rP"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa4c24cso285695966b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 02:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790240771; x=1790845571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FlRZg5cSdQ8+ctfQt6JigMOEPk3Cpgi5VtUV8uoBfp0=;
        b=NkPbC4rPJqbS263u5WlbxSq+zxJ9+37HiExFjge2c7Z+FsKKourAJu8P0uxnsgeK+X
         8kq2Mpq5wA7kiZkntkdOQXVMO0bcH7aeoLv3DoFFkBbIcvEu57xdyxN0jqF/IBUF6gU7
         kRGgcH6Azu1H+flaKXCJkmPknAcvufA4NuNDV8ZvuyGstQI7TSMIEYIOwkx7lLMjYQS+
         xtr9d2TiolVlpASyn+DNbhTJJhSq9xM59Vb2Op0V7FHNmjD4NwQjn8IdroBVoyJjRHeW
         D2IWSiDCacGO1vXeDgosEkeAw8Bxg6dGZUAunWEITCBOZUH/ZjcjrX/BaFPVqDW+GHOv
         8k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240771; x=1790845571;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FlRZg5cSdQ8+ctfQt6JigMOEPk3Cpgi5VtUV8uoBfp0=;
        b=JniE92mJoDziok0ZTRgCQDaGNpaQgWtqdDsQEUtoWZy5eViOMIIoNdl+n6vCgBveBN
         jFHh41r5Xo7sjXysz3hSkRKGVDCn5egxwuMX8QnH6lu76VJvb3/j/Abm/czaumd5x2Ld
         51KN735XozS1xuFUkKGeRyk6kZ5SSfltf7NBT6nIBfji/f+20oHe1ByktVH5zpUzctdK
         uCSmsznZxgLakSpHXBCLarqqeAi+IuqcL6bBfrvWU88+Y/OwCS03QPSttgh5vDQwmxaP
         r2dIgh7zAL3h0VxnLdoBF43vnYq6LfuVB8GZmRIqMdl1zjhMlXq5W5GKH9s8HQ/oDQ5f
         Gqiw==
X-Forwarded-Encrypted: i=1; AKwUvBwfjvj0EcSsOSr31BFFfhTgOYJEchmUHRQ19WrFhJfitKM3i6wt9Wv8tqQFWdKI6laqXtXgS4YbZ4noVav2FJJvZwQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l3xEL1WafqEVMXflXqgDCdBkY5K72rJI/KunkhS6nhTwS8UiIR
	kBeaniOrnv2/GuvqhAn6RMMeEJcpSbw8DXU6oJnCYe9EPyQmODt2Zdmx45iVcp7gNg==
X-Gm-Gg: AYBFou1uZdHKq7Sc55R9UQsqXb0Jdl7OJh30ofuq1HSER6fpT9cn5Qde9SS6Cq8nVV5
	ZrK9Ie+66eawzokAGZidyzQBoSisP9MqAojY46jaUrYgt5lXfocokTkH4qptXtgo4gFBYrN5DdK
	h+mmLJkmqD5NpMehqV+IMkMK/hezpiAyn2tP1kKO/I2lWsHBReYfyIfbA0U/bzC4cMkOrJ5PCAL
	I3rP/HPvQ1IHverGnCJWuY06dqdcJ8Q66IJ/Ma78HuxuBLDM8HOYJ48dQzEBNP3pHY13f1AkbEU
	2HVrd+YOHRtD3MtfhG7/+JNsUMIcM4TrY7/eRsgNLpX7PEC/TNJp+KKvrXDilychzS3ZrcXXOAe
	rgwvSiiBeiDUOBasDUznw/rgExWWgSWEmdNXD29qJI+SIzedJHAGUvRknzh0601inailoypL/g1
	4QOTq/23HihfeUvqbaiEW17sC1D3ub6ayLBWS/XyUlOOmrEWoBL6bdYQeElEYb80XXTcy/Yhm2E
	HtA7qnRAZFG9JT9oNbpE9MvQm8nGNrESwNam5XYTH0=
X-Received: by 2002:a17:907:9445:b0:c29:386c:58f2 with SMTP id a640c23a62f3a-c2ac232a3cfmr154324966b.38.1790240768840;
        Thu, 24 Sep 2026 02:06:08 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c417sm12388713f8f.18.2026.09.24.02.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:06:08 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:06:04 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	syzbot@lists.linux.dev,
	syzbot+de3d7f9bcc9212f3fae1@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ring-buffer: Fix false warning in
 ring_buffer_map_get_reader()
Message-ID: <arTnSXtsVHSomoAm@google.com>
References: <15bc282f-669e-4a94-911d-bb435513461f@mail.kernel.org>
 <20260924084946.20104-1-krystianmkaniewski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924084946.20104-1-krystianmkaniewski@gmail.com>

On Thu, Sep 24, 2026 at 10:49:42AM +0200, Krystian Kaniewski wrote:
> The mmap reader can warn when it catches up with a writer that is still
> committing events. rb_get_reader_page() returns NULL in this case, but
> ring_buffer_map_get_reader() treats that result as an error.
> 
> The initial rb_per_cpu_empty() check filters out an empty buffer, but it
> does not guarantee that the next reader page has committed data. Writers
> do not take reader_lock and can advance commit_page before publishing the
> committed length on the new page. rb_get_reader_page() can swap to that
> page, catch up with the writer and return NULL.
> 
> Handle NULL through the existing no-data exit without warning. Remove the
> caller's reader_page == commit_page check as well, since the reader-page
> helper already handles that case. The existing metadata update and return
> path remain in place.
> 
> Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
> Assisted-by: Gemini:gemini-3.8-flash syzbot
> Reported-by: syzbot+de3d7f9bcc9212f3fae1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=de3d7f9bcc9212f3fae1
> Link: https://syzkaller.appspot.com/ai_job?id=488adc18-a10e-42d2-a205-25327c38837f
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
> ---
> Changes since v1:
> - Rewrite the commit message to explain the race more concisely.
> - Clarify why the earlier empty-buffer check does not exclude this case.
> - Remove the redundant reader_page == commit_page check, as discussed
>   with Vincent. Let rb_get_reader_page() handle the caught-up reader.
> 
> v1: https://lore.kernel.org/all/15bc282f-669e-4a94-911d-bb435513461f@mail.kernel.org/
> 
>  kernel/trace/ring_buffer.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c03a555a6ba..9222fc881bc2 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7990,12 +7990,8 @@ consume:
>  		goto out;
>  	}
>  
> -	/* Did the reader catch up with the writer? */
> -	if (cpu_buffer->reader_page == cpu_buffer->commit_page)
> -		goto out;
> -
>  	reader = rb_get_reader_page(cpu_buffer);
> -	if (WARN_ON(!reader))
> +	if (!reader)
>  		goto out;
>  
>  	/* Check if any events were dropped */
> 
> base-commit: df2908090cda368b01ff43709f51890076c56157
> -- 
> 2.53.0

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

