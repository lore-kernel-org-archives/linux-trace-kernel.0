Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578BD156993;
	Thu, 11 Jul 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699091; cv=none; b=Uz+AZx9njLySBfnnsBkAjehXH4fiRQnu1xHfwmcOOkN13VJHym79DYSNoruH+tiMSpXxc5d2uZk+NsQnrmEhBHX4iiLlOvo1OJyQgSJEFTLU3CLKIf/rzzNP55IV+2m7HLak9nHWP48kAY7ZKSPdoh7SM/03cCcZbhbdNWDMff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699091; c=relaxed/simple;
	bh=4VkGcwTK7NS5884ZYM5DpYgIJ8oylqss9AoGtX7UMps=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+vyuXpmXZhnAI5/zi+0J87Cmk3KGnuBtOgXyQvzQs1z0QU8ZRf2SrO9oL2+ZvBSFxucWEt6lZV8B0GDOmhEcksmPvjEJCPtS5Im7Xy8Rckx0otmZOHrunDInbOXR+SKj57wY6t9sxJYeVpPPlIINS6UzEicNCJFD38r6vX2iwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYNvllLu; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYNvllLu"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77c1658c68so94778466b.0;
        Thu, 11 Jul 2024 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720699087; x=1721303887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWVsFOyE3ndT3xSslKal9U8tumbYoKdltL8oO0/zJmI=;
        b=fYNvllLuxSLscPwhshJSJgorqUBvGJvlyyYMWka73f8UNHwZaBm3XK9zsGorFiq+QL
         vdTJZhZF7iugVGcGCvr/UaUPdRS82lPoqYXoR3v8GnPNoxYVcMdxrKznMXvZbCaG5vS9
         4REbD5wPltfUZeTZ2GzTv3IJzPdr4wEvpYmyNPkAjmjcgqVOIxl2bawFiCr1VQ5hV/8Q
         wja2nOAxymKMyu4QaESu+DPeybFX3W6u7sg3Q0eFPzbA704tl35DNXI8i66CkOKcsqZY
         pFijAeauU5Y5b3xGfCbawtlSaXi+nirRQ7rmNPhfAQVT/jddIw3BJINJ9aBVA+XrPLhP
         ftGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720699087; x=1721303887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWVsFOyE3ndT3xSslKal9U8tumbYoKdltL8oO0/zJmI=;
        b=dm3DXy8ZdHizrjXIrmi764aMi68V9oFHQ3uzyXGd5cuG2Zpm0/U9yRwsZxHc++qdDX
         410+jK4EmYnsBqMFJQe5hQZ9K8AuiJD4V/IbhoQqRABrCLVcTW9upetSyeCDJhtrZGh9
         dCm1VCTZbatVNna0L5Xzf60/zz3HkTbNqku8D2ywRG7M45NVCh0bpGOpU0jJI2zOFxj4
         gYaBqOSIaQgheNRhCOs+SD18RWT/mmZAtw8kRWw9HfzmOb964mpv5DnhZdpK4RniOarO
         ayZY4rop+9sDWZ/yMpNz64Iq67UjXX4/Mk8SpygA9CRa0cWQGAAHoa39cLIBR0PQV8Xr
         cwMA==
X-Forwarded-Encrypted: i=1; AJvYcCXfmEFpz7or908q1iDGUoVQLtCS9gGN/GaAjIhoUJxKlNCfm/CoWg0K1RICghqg4LL+9EqaYmgudy6jYf/IF7B4c5cU3mQIIzf4KYO2wjxzbd+IWTermeuCbPCyCRlzbf3aRTLuyZHz3/dfR9pSONtb
X-Gm-Message-State: AOJu0YzKIBTk5pctcT1162wHPVnv6JQ1cIiFOUUCkKIxnQTtr9gboL3m
	JdNWXcgPski8LSm4IvgAu+VgSIux2XKFaYFBAV38L3kc0pSAgv4n
X-Google-Smtp-Source: AGHT+IG9W0ItYuE2l7FCvMw6VJgrPirWfwJT8roYevoHzEenR/AFP7poY7lQFJKUUvX50AA8Z1w+YA==
X-Received: by 2002:a17:907:7da8:b0:a6f:e456:4207 with SMTP id a640c23a62f3a-a780b88498fmr713852466b.61.1720699087349;
        Thu, 11 Jul 2024 04:58:07 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a855f09sm247380366b.164.2024.07.11.04.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:58:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 11 Jul 2024 13:58:04 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, clm@meta.com,
	paulmck@kernel.org
Subject: Re: [PATCH v2 01/11] perf/uprobe: Re-indent labels
Message-ID: <Zo_IzLWMXOzu34pT@krava>
References: <20240711110235.098009979@infradead.org>
 <20240711110400.309670567@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711110400.309670567@infradead.org>

On Thu, Jul 11, 2024 at 01:02:36PM +0200, Peter Zijlstra wrote:

SNIP

> @@ -1159,7 +1159,7 @@ static int __uprobe_register(struct inod
>  	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
>  		return -EINVAL;
>  
> - retry:
> +retry:
>  	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
>  	if (!uprobe)
>  		return -ENOMEM;
> @@ -1468,7 +1468,7 @@ static int xol_add_vma(struct mm_struct
>  	ret = 0;
>  	/* pairs with get_xol_area() */
>  	smp_store_release(&mm->uprobes_state.xol_area, area); /* ^^^ */
> - fail:
> +fail:
>  	mmap_write_unlock(mm);
>  
>  	return ret;
> @@ -1512,7 +1512,7 @@ static struct xol_area *__create_xol_are
>  	kfree(area->bitmap);
>   free_area:

hi,
missed this one and another one few lines before that ;-)

jirka

>  	kfree(area);
> - out:
> +out:
>  	return NULL;
>  }
>  
> @@ -1915,7 +1915,7 @@ static void prepare_uretprobe(struct upr
>  	utask->return_instances = ri;
>  
>  	return;
> - fail:
> +fail:
>  	kfree(ri);
>  }
>  
> @@ -2031,7 +2031,7 @@ static int is_trap_at_addr(struct mm_str
>  
>  	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
>  	put_page(page);
> - out:
> +out:
>  	/* This needs to return true for any variant of the trap insn */
>  	return is_trap_insn(&opcode);
>  }
> @@ -2159,7 +2159,7 @@ static void handle_trampoline(struct pt_
>  	utask->return_instances = ri;
>  	return;
>  
> - sigill:
> +sigill:
>  	uprobe_warn(current, "handle uretprobe, sending SIGILL.");
>  	force_sig(SIGILL);
>  
> 
> 
