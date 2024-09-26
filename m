Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49391494AC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373298; cv=none; b=s2SA1L49yQjbDhjYuwBYDkxXtTJXWzSrb54IYRNx41mYwA7kHTvP8KSdz2I3JMPN5zlWpThf2XdPDfYjSkOUGZnQsmfkr5b0IjBZqF0Uv0uBtNQMVvcEdz3TFomUd2bb9CdZNar0DV2becEPPXy/pIA9+HoPr9ZYDUm+RSd4EZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373298; c=relaxed/simple;
	bh=0aRGTn4qZNYsFHdSLtVVTADgFQWgEkqzVNawgnPQ2i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhB6epBocEOfn+0ZBXnUCrRROReauu+OoKHqEM1zMoLbjWQYHXYU2gQlpiAZXJxet690Bd9w5udXQLQPgvFTk1bkNkb+wTlq7JjfQwcNCUCEaJ4ZYWI08DsvTw/PUf7+Nz8dp61CrV5p1pJtDE10me2tt9RIKqlZNSDy9FMe7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mlawt2KJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mlawt2KJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727373295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JjoTb3DDkGQpWq+NC7yAzgO/O7gkqyS4FMGzMtxEfpU=;
	b=Mlawt2KJwCndRllI0V4pkeaVTmwq2CBLFbyONZsiiQzV78PoX8VoC7SpX56VafE2PmlDj3
	P+JNanN89a7qjOZlVB7hNisiD7Ogl8n2Fc1lyvKoFc0svYN5135dHmxjePQa4areyg6z6j
	AlqRayYIxQUF4scrZapVV7ERo4S28NI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-s3OMEBNYMqermERcrfojvQ-1; Thu, 26 Sep 2024 13:54:52 -0400
X-MC-Unique: s3OMEBNYMqermERcrfojvQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8a8d9a2a12so86724566b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373291; x=1727978091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjoTb3DDkGQpWq+NC7yAzgO/O7gkqyS4FMGzMtxEfpU=;
        b=Pb52/A9TRpnJnayl5fPTLvJ3G4OmJM5378IurP90/mRkSVGEMlmx/lbCGKsHhfnHRg
         JjmNq89zkWdXDNpIIUkOp8lsL7BXHaHRUZJFUJPdAlGPRLKB2qMGhsCr37bGu0l5JbQW
         aMx7be8zJm4QhjyLbqhZRIw/kQc3zW0ViTLVd5qgcnEA3LQpMDxxqeLjBhR/DJN5rlhI
         oJm65Wec3KnWwpLZg2jgtipP+4SZW0OyqdXn5pnJOvAPqMV/zJX2C/YY+s9ZvhF+YApY
         /b9+SBErR943y1IaAiLvlKKEKLsMEi626pKC7FLTQZpN2IOOhZqg85UAkq4erindyHnE
         Y15Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAkq4ausoAKUjVfQ9RVszcLI91tTvjUGmDdDLt9+7yDWIJOKNCXPuDl36QNDYqsIIpnxYrmqPTfpVYAI1HlNOZmqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXItBV+iADmz+UuiNlDufBBYLdu1UiebSzmh0adL0ObelKDHe
	CvKgWFY7N8FyV6XX8io2/DfqovLfxJWINJkOY32pDuf9fJGzFxXxQmE6q9YsQQh5/MIe2ouePAq
	z5+ej6iYOjJmVG/yM9JWGh6DqYGI+LzJfsMcJTJUmXUSiXBkbT4A2VLuztMuadhhWoZX10g==
X-Received: by 2002:a17:907:1b96:b0:a93:ae71:994c with SMTP id a640c23a62f3a-a93c4aa6c84mr20387566b.57.1727373291484;
        Thu, 26 Sep 2024 10:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgJ2ce8we4Rd7DeLh3WEv+xfrahHxGE4lyf2Nkn1gqk5KwScN7/aCChIQ2CyyjKxqasmeoQQ==
X-Received: by 2002:a17:907:1b96:b0:a93:ae71:994c with SMTP id a640c23a62f3a-a93c4aa6c84mr20386166b.57.1727373291119;
        Thu, 26 Sep 2024 10:54:51 -0700 (PDT)
Received: from [10.100.0.2] ([94.101.114.121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bcccsm22614166b.173.2024.09.26.10.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 10:54:50 -0700 (PDT)
Message-ID: <f8546c5d-fa2e-416f-8a1b-431025b4df4d@redhat.com>
Date: Thu, 26 Sep 2024 19:54:48 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/tracing: Mention that
 RESET_ATTACK_MITIGATION can clear memory
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mike Rapoport <mike.rapoport@gmail.com>, Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20240926130159.19e6d0e2@rorschach.local.home>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240926130159.19e6d0e2@rorschach.local.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26-Sep-24 7:01 PM, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> At the 2024 Linux Plumbers Conference, I was talking with Hans de Goede
> about the persistent buffer to display traces from previous boots. He
> mentioned that UEFI can clear memory. In my own tests I have not seen
> this. He later informed me that it requires the config option:
> 
>  CONFIG_RESET_ATTACK_MITIGATION
> 
> It appears that setting this will allow the memory to be cleared on boot
> up, which will definitely clear out the trace of the previous boot.
> 
> Add this information under the trace_instance in kernel-parameters.txt
> to let people know that this can cause issues.
> 
> Link: https://lore.kernel.org/all/20170825155019.6740-2-ard.biesheuvel@linaro.org/
> 
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bb48ae24ae69..f9b79294f84a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6850,6 +6850,9 @@
>  
>  				reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff^traceprintk@trace,sched,irq
>  
> +			Note, CONFIG_RESET_ATTACK_MITIGATION can force a memory reset on boot which
> +			will clear any trace that was stored.
> +
>  			See also Documentation/trace/debugging.rst
>  
>  

