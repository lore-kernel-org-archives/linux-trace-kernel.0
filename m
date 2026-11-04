Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817797;
	b=hGX3WMxFD/ivovELZdwCIgD8oDEdVbDW3GMxsDxvp0SyMHl1cRR1GvlcEmT0oNEZBPEC
	 /1SS7quRPsN2AGHLEbElkPvquo324/Fch/egqKWmNLDTbY5iUJDchQtwm5qAbo8qEljXk
	 8YIrTA7c1DaIWUS9VztV7MHWlFdFadODgwgBgCY21TQ+rBtAh0BinTRpEibFhrb7pEmgH
	 pjB2RoW8m7YybC2OE6a0ZPGksAhxEnxjieIMED8BfcNVZndgb7Ps00P523ZdnHxiKmZpj
	 Pfwl06eCE0G9SY1INrtO+TNr9dhk7yyUXkkHm92GYhuFsT1DzyoFVt6vxkFyICe2RVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817797;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=8/qRR8BDbExzEOpnKA+f9ikt3XSUIBNwoORoY6Ap2Wk=;
	b=qzMGVBFhOcrKcBJp7q+r/vE3mYe+hUgsh2+Sb3dlsgMIRSWNMPXYOUzSL6KLUSg06zWX
	 Ldm1pc0CPXcrfRv8OR8Mn3FLTWSNYvdD2/CdGmWkLNCCnmySBIJUkHPbHLTWG3h7cPS7O
	 S+h/LQ6lSBjxgejd6kIh+MQaTNwZH/21WyXUwqPawd/K894Si8cWzHG48td1xqz/rOHNg
	 bULfn4r0sP7budUnNQZWU/GIXlWK612pUlM2XGOSnG7sla0a11ua0kKOPl/Dz1UJ+JULA
	 mfn1fu+i1dxwD2W5v+BWnshQNbD8jWe27wGVnm0b0ht5HruEY/9MarnXSu164zJ0RSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=7LviCZ8w;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7C606A31B;
	Wed,  4 Nov 2026 18:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3E7C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=7LviCZ8w
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 1843DA83E4;
	Wed,  4 Nov 2026 18:43:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id D83351B;
	Wed,  4 Nov 2026 18:43:11 +0000 (UTC)
Date: Wed, 4 Nov 2026 13:43:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ftrace: speed up module enable by binary searching
 module symbols
Message-ID: <20261104134310.5cec1ebe@gandalf.local.home>
In-Reply-To: <20260916082715.320853-1-tianyaxiong@kylinos.cn>
References: <20260916082715.320853-1-tianyaxiong@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8gsydjfnpk13g89w43ig6f1it3fhd4zs
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D83351B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Aq5xkGcGQvKA6IKuSfYk84dlOjr7KCRY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=8/qRR8BDbExzEOpnKA+f9ikt3XSUIBNwoORoY6Ap2Wk=; b=7LviCZ8wK3AMnccnGGEpQTO31Onui4SIihuNAmOlNMEfjnCOJERWtV/n0gvWqZPplltL61u4POPaUjz/0dEF5dwl66wNKl83JTkckbGiVrDmffkf664SIztFYyibeSBbM5sEWHHT/eWdcAQ1KowihuwM2j/1mdGNFb5b0Ege1Bc=
X-HE-Tag: 1793817791-932945
X-HE-Meta: U2FsdGVkX1+nvCAwa6XLaxgBE8DeVdDcAFsjNwyWt9yCZTjBQWwpNAonWZz/oV0vOfGebmXzcDfzGo6i/YG/hD3rGTKpQTT1a+hnxohrJz+M0hZGsvqbT8g28Z9MamtjxA2WmQZXJUvXNNMj+gkC0I4U8WvodxhLj3nHek6GPlBMobTwntQfvkbrCBfOlTf348s7yKDE1MsRFZbkhjvZ9YsEq8XC4DLPrOGy3oD6WqFFBaptW7LoJ6mB+OdcfqFnz8EKHhd83xo+DaUsDzS/gzLCPRGUudp3jJIBt+eFUWqzkKUHTvZZ+Tb7u3HI0Dul

On Wed, 16 Sep 2026 16:27:15 +0800
Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
> 
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  kernel/trace/ftrace.c | 131 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 673a54fdf392..92ba9a4dfa69 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -26,6 +26,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/bsearch.h>
>  #include <linux/module.h>
> +#include <linux/module_symbol.h>
>  #include <linux/ftrace.h>
>  #include <linux/sysctl.h>
>  #include <linux/slab.h>
> @@ -8010,11 +8011,137 @@ void ftrace_release_mod(struct module *mod)
>  	}
>  }
>  
> +#ifdef FTRACE_MCOUNT_MAX_OFFSET
> +/*
> + * ftrace_module_enable() validates every record with test_for_valid_rec(),
> + * which walks the whole symbol table of a module for each address in it, so a
> + * large module loads in quadratic time.  Search a sorted copy of the symbol
> + * addresses instead, the way get_symbol_pos() searches the kallsyms table.
> + * The array is an accelerator only; records it cannot resolve are tested the
> + * old way, so the verdict does not change.
> + */
> +struct ftrace_mod_syms {
> +	unsigned int	nr;
> +	unsigned long	addr[];	/* sorted, @nr entries */
> +};
> +
> +static int ftrace_mod_syms_cmp(const void *a, const void *b)
> +{
> +	unsigned long va = *(const unsigned long *)a;
> +	unsigned long vb = *(const unsigned long *)b;
> +
> +	return (va > vb) - (va < vb);
> +}

Interesting compare technique. I usually do:

static int ftrace_mod_syms_cmp(const void *a, const void *b)
{
	unsigned long va = *(const unsigned long *)a;
	unsigned long vb = *(const unsigned long *)b;

	if (va < vb)
		return -1;

	return va > vb;
}

But I wanted to compare them, so I wrote this:

int cmp1(const void *a, const void *b)
{
        int A = *(const int *)a;
        int B = *(const int *)b;

        return (A > B) - (A < B);
}

int cmp2(const void *a, const void *b)
{
        int A = *(const int *)a;
        int B = *(const int *)b;

        if (A < B)
                return -1;
        return A > B;
}

And complied with gcc with -O2 and the result was this:

0000000000000000 <cmp1>:
   0:   8b 06                   mov    (%rsi),%eax
   2:   39 07                   cmp    %eax,(%rdi)
   4:   0f 9f c0                setg   %al
   7:   0f 9c c2                setl   %dl
   a:   0f b6 d2                movzbl %dl,%edx
   d:   0f b6 c0                movzbl %al,%eax
  10:   29 d0                   sub    %edx,%eax
  12:   c3                      ret
  13:   66 90                   xchg   %ax,%ax
  15:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
  1c:   00 00 00 00 

0000000000000020 <cmp2>:
  20:   8b 06                   mov    (%rsi),%eax
  22:   39 07                   cmp    %eax,(%rdi)
  24:   ba ff ff ff ff          mov    $0xffffffff,%edx
  29:   0f 9f c0                setg   %al
  2c:   0f b6 c0                movzbl %al,%eax
  2f:   0f 4c c2                cmovl  %edx,%eax
  32:   c3                      ret

It looks like my version is a bit better with gcc.

I complied with clang and it did this:

0000000000000000 <cmp1>:
   0:   8b 07                   mov    (%rdi),%eax
   2:   3b 06                   cmp    (%rsi),%eax
   4:   0f 9c c0                setl   %al
   7:   0f 9f c1                setg   %cl
   a:   28 c1                   sub    %al,%cl
   c:   0f be c1                movsbl %cl,%eax
   f:   c3                      ret

0000000000000010 <cmp2>:
  10:   8b 07                   mov    (%rdi),%eax
  12:   3b 06                   cmp    (%rsi),%eax
  14:   0f 9c c0                setl   %al
  17:   0f 9f c1                setg   %cl
  1a:   28 c1                   sub    %al,%cl
  1c:   0f be c1                movsbl %cl,%eax
  1f:   c3                      ret

Which made the two identical!

Probably just a nit, but food for thought if you want to keep your method
or switch to mine ;-) I won't be picky about it.


> +
> +static struct ftrace_mod_syms *ftrace_mod_syms_alloc(struct module *mod)
> +{
> +	struct mod_kallsyms *kallsyms;
> +	struct ftrace_mod_syms *syms;
> +	unsigned int i, nr = 0;
> +
> +	/* mod->kallsyms is not replaced until do_init_module() returns. */
> +	rcu_read_lock();
> +	kallsyms = rcu_dereference(mod->kallsyms);
> +	rcu_read_unlock();

The above was already discussed.

> +
> +	if (!kallsyms || kallsyms->num_symtab < 2)
> +		return NULL;
> +
> +	syms = kvmalloc(struct_size(syms, addr, kallsyms->num_symtab),
> +			GFP_KERNEL);
> +	if (!syms)
> +		return NULL;
> +
> +	/* The symbols find_kallsyms_symbol() would consider. */
> +	for (i = 1; i < kallsyms->num_symtab; i++) {
> +		const Elf_Sym *sym = &kallsyms->symtab[i];
> +		const char *name = kallsyms->strtab + sym->st_name;
> +
> +		if (sym->st_shndx == SHN_UNDEF || !*name ||
> +		    is_mapping_symbol(name))
> +			continue;
> +
> +		syms->addr[nr++] = kallsyms_symbol_value(sym);
> +	}
> +	syms->nr = nr;
> +
> +	if (nr > 1)
> +		sort(syms->addr, nr, sizeof(syms->addr[0]), ftrace_mod_syms_cmp,
> +		     NULL);
> +
> +	return syms;
> +}
> +
> +/* The verdict test_for_valid_rec() would give, without walking the table. */
> +static bool ftrace_mod_rec_is_valid(struct module *mod,
> +				    const struct ftrace_mod_syms *syms,
> +				    struct dyn_ftrace *rec)
> +{
> +	unsigned long base, best;
> +	unsigned int lo, hi;
> +
> +	if (!syms)
> +		return test_for_valid_rec(rec) != 0;
> +
> +	/* A record is in executable memory; anything else kallsyms answers. */
> +	if (within_module_mem_type(rec->ip, mod, MOD_TEXT))
> +		base = (unsigned long)mod->mem[MOD_TEXT].base;
> +	else if (within_module_mem_type(rec->ip, mod, MOD_INIT_TEXT))
> +		base = (unsigned long)mod->mem[MOD_INIT_TEXT].base;
> +	else
> +		return test_for_valid_rec(rec) != 0;
> +
> +	/* The closest address at or below @rec->ip, if there is one. */
> +	best = 0;
> +	for (lo = 0, hi = syms->nr; lo < hi; ) {
> +		unsigned int mid = lo + (hi - lo) / 2;
> +
> +		if (syms->addr[mid] <= rec->ip)
> +			lo = mid + 1;
> +		else
> +			hi = mid;
> +	}
> +	if (lo)
> +		best = syms->addr[lo - 1];
> +
> +	/*
> +	 * No symbol, or only ones below @base: let kallsyms_lookup() answer,
> +	 * as it also looks in the BPF and ftrace trampoline tables.
> +	 */
> +	if (best < base)
> +		return test_for_valid_rec(rec) != 0;
> +
> +	return rec->ip - best <= FTRACE_MCOUNT_MAX_OFFSET;
> +}
> +#else
> +struct ftrace_mod_syms;
> +
> +static inline struct ftrace_mod_syms *ftrace_mod_syms_alloc(struct module *mod)
> +{
> +	return NULL;
> +}
> +
> +static inline bool ftrace_mod_rec_is_valid(struct module *mod,
> +					   const struct ftrace_mod_syms *syms,
> +					   struct dyn_ftrace *rec)
> +{
> +	return test_for_valid_rec(rec) != 0;
> +}
> +#endif /* FTRACE_MCOUNT_MAX_OFFSET */
> +
>  void ftrace_module_enable(struct module *mod)
>  {
> +	struct ftrace_mod_syms *syms;

Hmm, remove this...


>  	struct dyn_ftrace *rec;
>  	struct ftrace_page *pg;
>  
> +	/*
> +	 * Allocates, so build it before taking ftrace_lock.  It is skipped when
> +	 * ftrace never came up, where the loop below would not run anyway; that
> +	 * also makes reading ftrace_disabled without the lock safe.
> +	 */
> +	syms = ftrace_disabled ? NULL : ftrace_mod_syms_alloc(mod);

and make the above:

	struct ftrace_mod_syms *syms __free(kvfree) =
		ftrace_disabled ? NULL : ftrace_mod_syms_alloc(mod);


> +
>  	mutex_lock(&ftrace_lock);
>  
>  	if (ftrace_disabled)
> @@ -8050,7 +8177,7 @@ void ftrace_module_enable(struct module *mod)
>  		cond_resched();
>  
>  		/* Weak functions should still be ignored */
> -		if (!test_for_valid_rec(rec)) {
> +		if (!ftrace_mod_rec_is_valid(mod, syms, rec)) {
>  			/* Clear all other flags. Should not be enabled anyway */
>  			rec->flags = FTRACE_FL_DISABLED;
>  			continue;
> @@ -8087,6 +8214,8 @@ void ftrace_module_enable(struct module *mod)
>   out_unlock:
>  	mutex_unlock(&ftrace_lock);
>  
> +	kvfree(syms);

Then we can also remove that.

Thanks,

-- Steve

> +
>  	process_cached_mods(mod->name);
>  }
>  

