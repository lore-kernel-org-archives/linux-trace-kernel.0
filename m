Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DC4C6FD1D
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 21 Mar 2023 15:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjCUPRd (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 21 Mar 2023 11:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjCUPR2 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:17:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48542DE75
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:17:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v1so7972864wrv.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679411840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2GoInk7d9u47eng1vTzYqIGp8bdKWZRL2lDveNBhNVo=;
        b=Cgzx71bgHE21nUmP0hjEF26eip8TPlh3F8/FjPtJF2bioLbK7ZA+qBIyMNLToyMypK
         yqqUc1Irx30LJcAWdFUqSgqFcL0Ols5bQz4IMEx6s0PYC3r+itMIGJUFyAqoSB7Qcx1L
         XNJXVyOQ1tfk0dL9L4BqV1AGQ3SBnqD43/S6pidHoXuCcAaeOfK3zAcNN2IY/pV8aJny
         /asGrn/D1/4v3lr6oJRoVx9TwojCIB2B5voWSF+xkpMbieZR/NowITOlYd7i5B7IWtLT
         bMUm2b2wKEllu4aPRMX22AxcsOo7V5J/0bzrHGkunSkkQ7LFtC+8skcNPVW7tvd2/Wu7
         OKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679411840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GoInk7d9u47eng1vTzYqIGp8bdKWZRL2lDveNBhNVo=;
        b=er8G4OI4mZbynyGPB0QO23NaFbq1gXFoltjKGblttst0HrNQRDMFrS1pwNxn1XtHYs
         syFy7UCqNk3V8lUwEabCcBeAPNoAqTszxRuGwtg2m/R/SqQaAigyuMSFwJUvonak14Dy
         jNwyb8NIWLvTcGqB4ZTmZgYGVyEUHh08OZZTduWeMgV46lhwn8F7FCxbclElEV2aKPjq
         HaE/mrYJahXz39ojdlgK8pgH1mIrU6Glr6e9JehdJcgB3W29V4FMf+ocsy8Qx+g2cLS7
         B/sDyKJ7x5Dzd0CfTVTFOly3DZNUDknCsC+9QpD+T0cL/yKah+7UrI3fL97tdBL5O6AZ
         kOrw==
X-Gm-Message-State: AO0yUKWT+Rh5viaq4BNb1Dj5qL3JlD3FrhXdfibezFW6+2hZzE6dVO8m
        kGgQBb2CyFPXLVBMRhxIZ9fcqrynYbrsS1U4StPB5w==
X-Google-Smtp-Source: AK7set/c9amb2MXvWMJuVzlYww2wkU04NIoAsnkM/hMhnYMf7zSMqJy/vh70Jj3/dkR9KvPgbxuVvQ==
X-Received: by 2002:a5d:4f09:0:b0:2cf:e436:f722 with SMTP id c9-20020a5d4f09000000b002cfe436f722mr2724274wru.64.1679411840395;
        Tue, 21 Mar 2023 08:17:20 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d4a08000000b002c3f03d8851sm11518772wrq.16.2023.03.21.08.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 08:17:20 -0700 (PDT)
Date:   Tue, 21 Mar 2023 15:17:15 +0000
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZBnKe55cvTZybZLF@google.com>
References: <20230317143310.1604700-1-vdonnefort@google.com>
 <20230317143310.1604700-2-vdonnefort@google.com>
 <20230320214516.01c18367@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320214516.01c18367@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:45:16PM -0400, Steven Rostedt wrote:
> On Fri, 17 Mar 2023 14:33:09 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > Also, the meta-page being... a single page, this limits at the moment the
> > number of pages in the ring-buffer that can be mapped: ~3MB on a 4K pages
> > system.
> 
> I hate this limitation, so I fixed it ;-)

Thanks a lot for having a look. Do you mind if I fold this in my patch for a V2?

> 
> I added a meta_page_size field to the meta page, and user space can do:
> 
> 	meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
> 	if (meta == MAP_FAILED)
> 		pdie("mmap");
> 
> 	map = meta;
> 	meta_len = map->meta_page_size;
> 
> 	if (meta_len > page_size) {
> 		munmap(meta, page_size);
> 		meta = mmap(NULL, meta_len, PROT_READ, MAP_SHARED, fd, 0);
> 		if (meta == MAP_FAILED)
> 			pdie("mmap");
> 		map = meta;
> 	}
> 
> This appears to work (but I'm still testing it).
> 
> -- Steve
> 
> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> index 24bcec754a35..12f3f7ee33d9 100644
> --- a/include/uapi/linux/trace_mmap.h
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -18,6 +18,7 @@ struct ring_buffer_meta_page {
>  	__u32	reader_page;
>  	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
>  	__u32	data_page_head;	/* index of data_pages[] */
> +	__u32	meta_page_size;	/* size of the meta page */

Do we want a specific field here? That could be deduced from nr_data_pages()
quite easily?


>  	__u32	data_pages[];
>  };
>  
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 10a17e78cfe6..77c92e4a7adc 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -526,6 +526,7 @@ struct ring_buffer_per_cpu {
>  	u64				read_stamp;
>  
>  	int				mapped;
> +	int				meta_order;
>  	struct mutex			mapping_lock;
>  	unsigned long			*page_ids;	/* ID to addr */
>  	struct ring_buffer_meta_page	*meta_page;
> @@ -5898,7 +5899,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  EXPORT_SYMBOL_GPL(ring_buffer_read_page);
>  
>  #define META_PAGE_MAX_PAGES \
> -	((PAGE_SIZE - (offsetof(struct ring_buffer_meta_page, data_page_head))) >> 2)
> +	((PAGE_SIZE - (offsetof(struct ring_buffer_meta_page, data_pages))) >> 2)
>

[...]
