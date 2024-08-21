Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383414D2B4;
	Wed, 21 Aug 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255770; cv=none; b=VsWu7VF158HGwSe9Yib1SmrGd7IaLFHG8lfxbiWYuPtZQzQJKyw10oBX74d0AUf8wKzb2elJcTym0XT6zSToPFKZfiYzjSMahrLStq/HXGXyQIJZLWPa+rEtPFAIXfy7i/1DNtucDwWMAgsjCLgPUHPZIDIhl9iyv6THheWajJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255770; c=relaxed/simple;
	bh=tk3tV88gD6hBTFFbuvzrZ2GOP6Y+PNIPKOVHzLmKSko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKxHONyowtnigK1CJp7s1y7jqi0o6SjQJ7LLR6zVjCQpEvKaT3eSa8iq5T22HB6W5Yc5W1I/+AjLSBOOL7L9HZXbpCEV10892FKTN1xBzPR9aLNsc43liSEBTAfSRbdlFoA/FP5etjVwOb0unh3mOR1BdnlktWalXJagry4qoK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AA5C32781;
	Wed, 21 Aug 2024 15:56:07 +0000 (UTC)
Date: Wed, 21 Aug 2024 11:56:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, david@redhat.com
Subject: Re: [PATCH v2] ring-buffer: Align meta-page to sub-buffers for
 improved TLB usage
Message-ID: <20240821115636.3546f684@gandalf.local.home>
In-Reply-To: <20240628104611.1443542-1-vdonnefort@google.com>
References: <20240628104611.1443542-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 11:46:11 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
> index a9006fa7097e..4bb0192e43f3 100644
> --- a/tools/testing/selftests/ring-buffer/map_test.c
> +++ b/tools/testing/selftests/ring-buffer/map_test.c
> @@ -228,6 +228,20 @@ TEST_F(map, data_mmap)
>  	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
>  		    desc->cpu_fd, meta_len);
>  	ASSERT_EQ(data, MAP_FAILED);
> +
> +	/* Verify meta-page padding */
> +	if (desc->meta->meta_page_size > getpagesize()) {
> +		void *addr;
> +
> +		data_len = desc->meta->meta_page_size;
> +		data = mmap(NULL, data_len,
> +			    PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
> +		ASSERT_NE(data, MAP_FAILED);
> +
> +		addr = (void *)((unsigned long)data + getpagesize());
> +		ASSERT_EQ(*((int *)addr), 0);

Should we make this a test that the entire page is zero?

		for (int i = desc->meta->meta_struct_len; i < desc->meta->meta_page_size; i += sizeof(int))
			ASSERT_EQ(((int *)data)[i], 0);

?

> +		munmap(data, data_len);
> +	}
>  }

Also, looking at the init, if for some reason (I highly doubt it may
happen) that the meta_struct_len becomes bigger than page_size, we should
update the init section to:

	/* Handle the case where meta_struct_len is greater than page size */
	if (page_size < desc->meta->meta_struct_len) {
		/* meta_page_size is >= meta_struct_len */
		page_size = desc->meta->meta_page_size;
		munmap(desc->meta, page_size);
		map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
		if (map == MAP_FAILED)
			return -errno;
		desc->meta = (struct trace_buffer_meta *)map;
	}

-- Steve
