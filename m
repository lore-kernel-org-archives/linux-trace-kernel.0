Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40281385;
	Tue,  4 Jun 2024 06:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717481048; cv=none; b=dVbvbK/KyaR/YDSzA8p73BHri4GerLZL19vZgbJbArbVR8AbhQDGEMGXyVGRnru7gBhRWwyeenYNim+qJ1wek4oDc/W3TT7muQOWo6Nvf2noM994f4oUoQP4MPKZUAIgvYTNgp55rgGyxiBPF/E6ZZ22qsGNbmz7LuQnhntVkks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717481048; c=relaxed/simple;
	bh=M4B30GIS1d4lGziHl2ETRAmpCx3XEZtVoNK45XulINE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVxUc/6kYtGLCmRRid8K5zzUQMX1tHDTe5l5lCe4EpdtGlTfNyZG3p6YvRsmo1fRwS0xVZZTIhRP0taoyfTpVJ2Kr6YWWtemx2dAj3gSyH7FfyUFxmtyf+IfCoj9Npc7Gcsim7/kiXOONFodPKJTxoT0d+GFDzpEOgBjaiTDIG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9YONRBB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9YONRBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD7AC4AF08;
	Tue,  4 Jun 2024 06:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717481047;
	bh=M4B30GIS1d4lGziHl2ETRAmpCx3XEZtVoNK45XulINE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L9YONRBBvOyMLNAxTKGyxKrbkg5yDz5lKVyT/qK/teTXo3O/Coa90mwmoDF6gldfZ
	 549bZ0rtqFr0xSJEK9zQrls4yBpqvFYw2RCRynJvUIt7ZclNHyzPMACWbx5NuC0yk4
	 H9zlo4T0NwCR0H4F6tNNurbKzj7bHbBqnMngubuq+bs1YYwpsORpVtyf1vSV0ANwj0
	 2cnTDPxIQ5iitlGxygFMoAL+PvyR5NarSWwqa9h3MRnlgF7NwNvsqrt6bes2Z/vlz5
	 gp1FJrx31sV2EszXnZPxcOhZIADgRLMe0TcIdkmVyOE8Two0WsFw7u1f3FX5mM8sd3
	 0I1s/FHoLPH3g==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so58332501fa.2;
        Mon, 03 Jun 2024 23:04:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXA1Hpir+JcHdu5N4N5A0brijcysvcdAxzT0vAnhC29dtpJYdt0FFBIBC+4vhEvux1/2G50XVj29Pp6OKIeZjmE+8/Eed/sjO8ydgzoMHcpC+NzRe1MVztCgCEUjxApCVl01BE++jIaYvax0gWlDfN24UDl
X-Gm-Message-State: AOJu0YzNTOsyvedsSEr469u3KRqZRCgjf1TpHkpmO/XJBCNF8O+03S7u
	FwHb1Aiy0+uW9E9w/ZpXEB5r1l+ldiYUyhlBgKj/0HXRV8uw7PCcKFa6vUP6Y30WWvpRNjfQPuJ
	RQE3rOMhvxxmrycK6+oFtpzP12WE=
X-Google-Smtp-Source: AGHT+IHVlviNMyuiDTy8BXSpmmQsquH1nttnEqb9GRM155e1DzpJqqQMSfDQX+2d+pZK5cfpuPeWpv6RYnrY2Ix/7UU=
X-Received: by 2002:a2e:980d:0:b0:2d8:67a0:61b2 with SMTP id
 38308e7fff4ca-2ea9512c01dmr60165791fa.20.1717481045999; Mon, 03 Jun 2024
 23:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603233330.801075898@goodmis.org> <20240603233631.452433539@goodmis.org>
In-Reply-To: <20240603233631.452433539@goodmis.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 4 Jun 2024 08:03:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFoNT25+ZTFaqF8zj4VkN6FFbtX5Fntf+J-c33tW3TPUA@mail.gmail.com>
Message-ID: <CAMj1kXFoNT25+ZTFaqF8zj4VkN6FFbtX5Fntf+J-c33tW3TPUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Ross Zwisler <zwisler@google.com>, wklin@google.com, 
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Suleiman Souhlal <suleiman@google.com>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 01:35, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> In order to allow for requesting a memory region that can be used for
> things like pstore on multiple machines where the memory layout is not the
> same, add a new option to the kernel command line called "reserve_mem".
>
> The format is:  reserve_mem=nn:align:name
>
> Where it will find nn amount of memory at the given alignment of align.
> The name field is to allow another subsystem to retrieve where the memory
> was found. For example:
>
>   reserve_mem=12M:4096:oops ramoops.mem_name=oops
>
> Where ramoops.mem_name will tell ramoops that memory was reserved for it
> via the reserve_mem option and it can find it by calling:
>
>   if (reserve_mem_find_by_name("oops", &start, &size)) {
>         // start holds the start address and size holds the size given
>
> Link: https://lore.kernel.org/all/ZjJVnZUX3NZiGW6q@kernel.org/
>
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

You failed to point out in the commit message that the assumption here
is that this memory will retain its contents across a soft reboot. Or
am I misunderstanding this?

In any case, as I pointed out before, playing these games unilaterally
from the kernel side, i.e., without any awareness whatsoever from the
firmware and bootloader (which will not attempt to preserve RAM
contents), is likely to have a rather disappointing success ratio in
the general case. I understand this may be different for vertically
integrated software stacks like ChromeOS so perhaps it should live
there as a feature.

Then, as Kees points out, there is also the risk that the kernel
itself may be stepping on this memory before having realized that it
is reserved. At least ARM and x86 have decompressors with a
substantial amount of non-trivial placement logic that would need to
be made aware of this reservation. Note that EFI vs. non-EFI boot also
makes a difference here.


> ---
>  include/linux/mm.h |  2 +
>  mm/memblock.c      | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9849dfda44d4..b4455cc02f2c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4263,4 +4263,6 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
>  void vma_pgtable_walk_begin(struct vm_area_struct *vma);
>  void vma_pgtable_walk_end(struct vm_area_struct *vma);
>
> +int reserve_mem_find_by_name(const char *name, unsigned long *start, unsigned long *size);
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index d09136e040d3..a8bf0ee9e2b4 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2244,6 +2244,103 @@ void __init memblock_free_all(void)
>         totalram_pages_add(pages);
>  }
>
> +/* Keep a table to reserve named memory */
> +#define RESERVE_MEM_MAX_ENTRIES                8
> +#define RESERVE_MEM_NAME_SIZE          16
> +struct reserve_mem_table {
> +       char                    name[RESERVE_MEM_NAME_SIZE];
> +       unsigned long           start;
> +       unsigned long           size;
> +};
> +static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
> +static int reserved_mem_count;
> +
> +/* Add wildcard region with a lookup name */
> +static int __init reserved_mem_add(unsigned long start, unsigned long size,
> +                                  const char *name)
> +{
> +       struct reserve_mem_table *map;
> +
> +       if (!name || !name[0] || strlen(name) >= RESERVE_MEM_NAME_SIZE)
> +               return -EINVAL;
> +
> +       if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
> +               return -1;
> +
> +       map = &reserved_mem_table[reserved_mem_count++];
> +       map->start = start;
> +       map->size = size;
> +       strscpy(map->name, name);
> +       return 0;
> +}
> +
> +/**
> + * reserve_mem_find_by_name - Find reserved memory region with a given name
> + * @name: The name that is attached to a reserved memory region
> + * @start: If found, holds the start address
> + * @size: If found, holds the size of the address.
> + *
> + * Returns: 1 if found or 0 if not found.
> + */
> +int reserve_mem_find_by_name(const char *name, unsigned long *start, unsigned long *size)
> +{
> +       struct reserve_mem_table *map;
> +       int i;
> +
> +       for (i = 0; i < reserved_mem_count; i++) {
> +               map = &reserved_mem_table[i];
> +               if (!map->size)
> +                       continue;
> +               if (strcmp(name, map->name) == 0) {
> +                       *start = map->start;
> +                       *size = map->size;
> +                       return 1;
> +               }
> +       }
> +       return 0;
> +}
> +
> +/*
> + * Parse early_reserve_mem=nn:align:name
> + */
> +static int __init reserve_mem(char *p)
> +{
> +       phys_addr_t start, size, align;
> +       char *oldp;
> +       int err;
> +
> +       if (!p)
> +               return -EINVAL;
> +
> +       oldp = p;
> +       size = memparse(p, &p);
> +       if (p == oldp)
> +               return -EINVAL;
> +
> +       if (*p != ':')
> +               return -EINVAL;
> +
> +       align = memparse(p+1, &p);
> +       if (*p != ':')
> +               return -EINVAL;
> +
> +       start = memblock_phys_alloc(size, align);
> +       if (!start)
> +               return -ENOMEM;
> +
> +       p++;
> +       err = reserved_mem_add(start, size, p);
> +       if (err) {
> +               memblock_phys_free(start, size);
> +               return err;
> +       }
> +
> +       p += strlen(p);
> +
> +       return *p == '\0' ? 0: -EINVAL;
> +}
> +__setup("reserve_mem=", reserve_mem);
> +
>  #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
>  static const char * const flagname[] = {
>         [ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
> --
> 2.43.0
>
>
>
