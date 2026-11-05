Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844542;
	b=s4jeQWC66L/0YBrMilUztUhJzsSztQqM9aPQVUBu87q/Kcd1ZjYVnVmTyuyiXfKx1rkY
	 HrQ/ouONJwcYlPyptVniI94JmrlxQrrKNKH01OvX3/euWuXyOpHSzjdbGl7VjthWAdV89
	 u8ZL364VcjCn1eotiVPi9kXAAAdNuzVLFz8gSYvhgp+tSXqnmBOgqznvE5t5c44FNLd1Z
	 /BlcNRDBAs9t/WW9eqUPxdc3LO6N/EB8sh7hfgHZVuT0NbeGtkCq+cS7jCAJJy89gN4wG
	 0LY+ELvZHMrgZvWuJOxCpynLnP15fPVZ+AR4C68ws6saLMLJIXgg+W2yLb2ObM4lJ+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844542;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=SQgq6rlpol2K3xeU2F2fDnv2paP/T7YA03jLXDqG4Dk=;
	b=keZPuW9sTrDlsc48HXzokkLivc5P7HdJpn1m2uBTsS33kj7bVZ0SNfA4ySJIr5pjyhPl
	 FW8IdQf9/EE8fhCC1/dnZDsfV2fbf2socV07JlBr9TcYMDicT1Lw6Q6cnuQFzUSzejncZ
	 vTttkFHKlfTAsMAXuDyf4q6pbsg/muj5IfITnFXc3lPGv1Ki+uTtDTz5jNbGMVt57u/z2
	 QQq40X/bopZr4B4fByRvtRH6m4+ycqXdS0HHBq+P3FJNbPpvaHWOoUcwQoIjGtzbxiPnU
	 e+4nzEmgsg6pmAUpKM3JtPPlNwHQuZXyIBXe36Ku/UUJvi9L2mEPaIscBsEgMv0opXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37440606A326;
	Thu,  5 Nov 2026 02:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37440606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d9d02bc8d8bd11f19a56ed5b684f684d-20261105
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c6f694f3-00d0-467c-acbd-be2f9f3a7602,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:258a3d6ce4920a8cd0c21f11d44b5e16,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d9d02bc8d8bd11f19a56ed5b684f684d-20261105
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 450346635; Thu, 05 Nov 2026 10:08:53 +0800
Message-ID: <514ce95a-747c-45b0-91b6-3a5c03ff4e6d@kylinos.cn>
Date: Thu, 5 Nov 2026 10:08:51 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ftrace: speed up module enable by binary searching
 module symbols
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260916082715.320853-1-tianyaxiong@kylinos.cn>
 <20261104134310.5cec1ebe@gandalf.local.home>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20261104134310.5cec1ebe@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2026/11/5 02:43, Steven Rostedt wrote:
> On Wed, 16 Sep 2026 16:27:15 +0800
> Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>
> +static int ftrace_mod_syms_cmp(const void *a, const void *b)
> +{
> +	unsigned long va = *(const unsigned long *)a;
> +	unsigned long vb = *(const unsigned long *)b;
> +
> +	return (va > vb) - (va < vb);
> +}
> Interesting compare technique. I usually do:
>
> static int ftrace_mod_syms_cmp(const void *a, const void *b)
> {
> 	unsigned long va = *(const unsigned long *)a;
> 	unsigned long vb = *(const unsigned long *)b;
>
> 	if (va < vb)
> 		return -1;
>
> 	return va > vb;
> }
>
> But I wanted to compare them, so I wrote this:
>
> int cmp1(const void *a, const void *b)
> {
>         int A = *(const int *)a;
>         int B = *(const int *)b;
>
>         return (A > B) - (A < B);
> }
>
> int cmp2(const void *a, const void *b)
> {
>         int A = *(const int *)a;
>         int B = *(const int *)b;
>
>         if (A < B)
>                 return -1;
>         return A > B;
> }
>
> And complied with gcc with -O2 and the result was this:
>
> 0000000000000000 <cmp1>:
>    0:   8b 06                   mov    (%rsi),%eax
>    2:   39 07                   cmp    %eax,(%rdi)
>    4:   0f 9f c0                setg   %al
>    7:   0f 9c c2                setl   %dl
>    a:   0f b6 d2                movzbl %dl,%edx
>    d:   0f b6 c0                movzbl %al,%eax
>   10:   29 d0                   sub    %edx,%eax
>   12:   c3                      ret
>   13:   66 90                   xchg   %ax,%ax
>   15:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
>   1c:   00 00 00 00 
>
> 0000000000000020 <cmp2>:
>   20:   8b 06                   mov    (%rsi),%eax
>   22:   39 07                   cmp    %eax,(%rdi)
>   24:   ba ff ff ff ff          mov    $0xffffffff,%edx
>   29:   0f 9f c0                setg   %al
>   2c:   0f b6 c0                movzbl %al,%eax
>   2f:   0f 4c c2                cmovl  %edx,%eax
>   32:   c3                      ret
>
> It looks like my version is a bit better with gcc.
>
> I complied with clang and it did this:
>
> 0000000000000000 <cmp1>:
>    0:   8b 07                   mov    (%rdi),%eax
>    2:   3b 06                   cmp    (%rsi),%eax
>    4:   0f 9c c0                setl   %al
>    7:   0f 9f c1                setg   %cl
>    a:   28 c1                   sub    %al,%cl
>    c:   0f be c1                movsbl %cl,%eax
>    f:   c3                      ret
>
> 0000000000000010 <cmp2>:
>   10:   8b 07                   mov    (%rdi),%eax
>   12:   3b 06                   cmp    (%rsi),%eax
>   14:   0f 9c c0                setl   %al
>   17:   0f 9f c1                setg   %cl
>   1a:   28 c1                   sub    %al,%cl
>   1c:   0f be c1                movsbl %cl,%eax
>   1f:   c3                      ret
>
> Which made the two identical!
>
> Probably just a nit, but food for thought if you want to keep your method
> or switch to mine ;-) I won't be picky about it.

I didn't think about the assembly side of this at the time ;-), and your
version is valuable for this kind of optimization.

I tried both with the type we actually use (unsigned long, -O2; the
counts include ret):

gcc 12.3.0:
0000000000000000 <cmp1>:
   0:    48 8b 0f                 mov    (%rdi),%rcx
   3:    48 8b 16                 mov    (%rsi),%rdx
   6:    31 c0                    xor    %eax,%eax
   8:    48 39 ca                 cmp    %rcx,%rdx
   b:    0f 92 c0                 setb   %al
   e:    48 39 d1                 cmp    %rdx,%rcx
  11:    83 d8 00                 sbb    $0x0,%eax
  14:    c3                       ret
                              (8 insns, branchless)

0000000000000020 <cmp2>:
  20:    48 8b 17                 mov    (%rdi),%rdx
  23:    48 8b 0e                 mov    (%rsi),%rcx
  26:    b8 ff ff ff ff           mov    $0xffffffff,%eax
  2b:    48 39 ca                 cmp    %rcx,%rdx
  2e:    72 08                    jb     38 <cmp2+0x18>
  30:    31 c0                    xor    %eax,%eax
  32:    48 39 d1                 cmp    %rdx,%rcx
  35:    0f 92 c0                 setb   %al
  38:    c3                       ret
                              (9 insns, with a data-dependent branch)

clang 17.0.6:
0000000000000000 <cmp1>:
   0:    48 8b 0f                 mov    (%rdi),%rcx
   3:    31 c0                    xor    %eax,%eax
   5:    48 3b 0e                 cmp    (%rsi),%rcx
   8:    0f 97 c0                 seta   %al
   b:    83 d8 00                 sbb    $0x0,%eax
   e:    c3                       ret
                              (6 insns, branchless)

0000000000000010 <cmp2>:
  10:    48 8b 07                 mov    (%rdi),%rax
  13:    31 c9                    xor    %ecx,%ecx
  15:    48 3b 06                 cmp    (%rsi),%rax
  18:    0f 97 c1                 seta   %cl
  1b:    b8 ff ff ff ff           mov    $0xffffffff,%eax
  20:    0f 43 c1                 cmovae %ecx,%eax
  23: c3                       ret
                              (7 insns, branchless)

Your version is one instruction shorter for int, but for 64-bit gcc needs a
second compare after the branch to tell > from ==, and picks a branch
instead
of cmov, which is worse for a sort comparator.  So I kept the subtract form.

>
>> +
>> +static struct ftrace_mod_syms *ftrace_mod_syms_alloc(struct module *mod)
>> +{
>> +	struct mod_kallsyms *kallsyms;
>> +	struct ftrace_mod_syms *syms;
>> +	unsigned int i, nr = 0;
>> +
>> +	/* mod->kallsyms is not replaced until do_init_module() returns. */
>> +	rcu_read_lock();
>> +	kallsyms = rcu_dereference(mod->kallsyms);
>> +	rcu_read_unlock();
> The above was already discussed.
>
>> +
>> +	if (!kallsyms || kallsyms->num_symtab < 2)
>> +		return NULL;
>> +
>> +	syms = kvmalloc(struct_size(syms, addr, kallsyms->num_symtab),
>> +			GFP_KERNEL);
>> +	if (!syms)
>> +		return NULL;
>> +
>> +	/* The symbols find_kallsyms_symbol() would consider. */
>> +	for (i = 1; i < kallsyms->num_symtab; i++) {
>> +		const Elf_Sym *sym = &kallsyms->symtab[i];
>> +		const char *name = kallsyms->strtab + sym->st_name;
>> +
>> +		if (sym->st_shndx == SHN_UNDEF || !*name ||
>> +		    is_mapping_symbol(name))
>> +			continue;
>> +
>> +		syms->addr[nr++] = kallsyms_symbol_value(sym);
>> +	}
>> +	syms->nr = nr;
>> +
>> +	if (nr > 1)
>> +		sort(syms->addr, nr, sizeof(syms->addr[0]), ftrace_mod_syms_cmp,
>> +		     NULL);
>> +
>> +	return syms;
>> +}
>> +
>> +/* The verdict test_for_valid_rec() would give, without walking the table. */
>> +static bool ftrace_mod_rec_is_valid(struct module *mod,
>> +				    const struct ftrace_mod_syms *syms,
>> +				    struct dyn_ftrace *rec)
>> +{
>> +	unsigned long base, best;
>> +	unsigned int lo, hi;
>> +
>> +	if (!syms)
>> +		return test_for_valid_rec(rec) != 0;
>> +
>> +	/* A record is in executable memory; anything else kallsyms answers. */
>> +	if (within_module_mem_type(rec->ip, mod, MOD_TEXT))
>> +		base = (unsigned long)mod->mem[MOD_TEXT].base;
>> +	else if (within_module_mem_type(rec->ip, mod, MOD_INIT_TEXT))
>> +		base = (unsigned long)mod->mem[MOD_INIT_TEXT].base;
>> +	else
>> +		return test_for_valid_rec(rec) != 0;
>> +
>> +	/* The closest address at or below @rec->ip, if there is one. */
>> +	best = 0;
>> +	for (lo = 0, hi = syms->nr; lo < hi; ) {
>> +		unsigned int mid = lo + (hi - lo) / 2;
>> +
>> +		if (syms->addr[mid] <= rec->ip)
>> +			lo = mid + 1;
>> +		else
>> +			hi = mid;
>> +	}
>> +	if (lo)
>> +		best = syms->addr[lo - 1];
>> +
>> +	/*
>> +	 * No symbol, or only ones below @base: let kallsyms_lookup() answer,
>> +	 * as it also looks in the BPF and ftrace trampoline tables.
>> +	 */
>> +	if (best < base)
>> +		return test_for_valid_rec(rec) != 0;
>> +
>> +	return rec->ip - best <= FTRACE_MCOUNT_MAX_OFFSET;
>> +}
>> +#else
>> +struct ftrace_mod_syms;
>> +
>> +static inline struct ftrace_mod_syms *ftrace_mod_syms_alloc(struct module *mod)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline bool ftrace_mod_rec_is_valid(struct module *mod,
>> +					   const struct ftrace_mod_syms *syms,
>> +					   struct dyn_ftrace *rec)
>> +{
>> +	return test_for_valid_rec(rec) != 0;
>> +}
>> +#endif /* FTRACE_MCOUNT_MAX_OFFSET */
>> +
>>  void ftrace_module_enable(struct module *mod)
>>  {
>> +	struct ftrace_mod_syms *syms;
> Hmm, remove this...
>
>
>>  	struct dyn_ftrace *rec;
>>  	struct ftrace_page *pg;
>>  
>> +	/*
>> +	 * Allocates, so build it before taking ftrace_lock.  It is skipped when
>> +	 * ftrace never came up, where the loop below would not run anyway; that
>> +	 * also makes reading ftrace_disabled without the lock safe.
>> +	 */
>> +	syms = ftrace_disabled ? NULL : ftrace_mod_syms_alloc(mod);
> and make the above:
>
> 	struct ftrace_mod_syms *syms __free(kvfree) =
> 		ftrace_disabled ? NULL : ftrace_mod_syms_alloc(mod);
>
>
>> +
>>  	mutex_lock(&ftrace_lock);
>>  
>>  	if (ftrace_disabled)
>> @@ -8050,7 +8177,7 @@ void ftrace_module_enable(struct module *mod)
>>  		cond_resched();
>>  
>>  		/* Weak functions should still be ignored */
>> -		if (!test_for_valid_rec(rec)) {
>> +		if (!ftrace_mod_rec_is_valid(mod, syms, rec)) {
>>  			/* Clear all other flags. Should not be enabled anyway */
>>  			rec->flags = FTRACE_FL_DISABLED;
>>  			continue;
>> @@ -8087,6 +8214,8 @@ void ftrace_module_enable(struct module *mod)
>>   out_unlock:
>>  	mutex_unlock(&ftrace_lock);
>>  
>> +	kvfree(syms);
> Then we can also remove that.

Done as suggested; the explicit kvfree() is gone.  The v2 also carries the
rcu_dereference_raw() change discussed earlier.

I will send the v2 shortly, after I finish testing it today.

Thanks,
Yaxiong


>
> Thanks,
>
> -- Steve
>
>> +
>>  	process_cached_mods(mod->name);
>>  }
>>
