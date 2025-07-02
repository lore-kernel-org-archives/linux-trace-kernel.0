Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D248275AF8;
	Wed,  2 Jul 2025 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461514; cv=none; b=dZ8FBT69XXbHt0IYto84PI7K6ZXwIYWGjcH8SZnWJCX8NbW19VtmV6rmHGpUSwcs3wgK3uUe3Ty4jQVEIjn0R+eqvzlbGqUN6L5HLxfh/+FRhTeThwAoxA23K6i4kzQF23aHTnopfswhs0GRUHD+zsakSc5NQnH06PWi50a5L68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461514; c=relaxed/simple;
	bh=6DbrUrjzqWPuGW013KxBtcgEZYWvCNIy8XMvL+T0r2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvggNev95GcUFjF3dYvF99tn8Bie/awmgnBcDWsbAL30pZSo8Aznw79yfTgacD6+GMZN8v+Jl+WIK2O8KQp0ooN7Z89LlRfNIA1BXqR9FCmm48dZjL7fRhT7OdYdH1/UPzvB9u8BUXCYxzRnb1CjAC/UfyDMdJHZdDT+ZGG194Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 330F344211;
	Wed,  2 Jul 2025 13:05:07 +0000 (UTC)
Message-ID: <6d478129-324a-4c5a-8258-4abe3d0732d6@ghiti.fr>
Date: Wed, 2 Jul 2025 15:05:06 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Random oops on SG2042 with Linux 6.16-rc and dynamic
 ftrace
To: Yao Zi <ziyao@disroot.org>, Andy Chiu <andybnac@gmail.com>,
 alexghiti@rivosinc.com, palmer@dabbelt.com, Andy Chiu
 <andy.chiu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Mark Rutland <mark.rutland@arm.com>,
 puranjay12@gmail.com, paul.walmsley@sifive.com, greentime.hu@sifive.com,
 nick.hu@sifive.com, nylon.chen@sifive.com, eric.lin@sifive.com,
 vicent.chen@sifive.com, zong.li@sifive.com, yongxuan.wang@sifive.com,
 samuel.holland@sifive.com, olivia.chu@sifive.com, c2232430@gmail.com
Cc: Han Gao <rabenda.cn@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 regressions@lists.linux.dev, linux-riscv@lists.infradead.org
References: <aGODMpq7TGINddzM@pie.lan>
 <b060e694-caa0-4aa5-ac67-75531a5f60eb@ghiti.fr> <aGUO8L7oXpvEpvZo@pie.lan>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <aGUO8L7oXpvEpvZo@pie.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepudffueegvddtgeeluefhueetteeugeeffeekhfehffdvudfhgedvheduudekffegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpihhnfhhrrgguvggrugdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeejlegutdemleelfhgtmeeirghfsgemhedvtdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeejlegutdemleelfhgtmeeirghfsgemhedvtdelpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeejlegutdemleelfhgtmeeirghfsgemhedvtdelngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtoheprghnugihsghnrggtsehgmhgrihhlrdgtohhmpdhrt
 ghpthhtoheprghlvgigghhhihhtihesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghnugihrdgthhhiuhesshhifhhivhgvrdgtohhmpdhrtghpthhtohepsghjohhrnhesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepphhurhgrnhhjrgihuddvsehgmhgrihhlrdgtohhm

Hi Yao,

On 7/2/25 12:50, Yao Zi wrote:
> On Tue, Jul 01, 2025 at 02:27:32PM +0200, Alexandre Ghiti wrote:
>> Hi Yao,
>>
>> On 7/1/25 08:41, Yao Zi wrote:
>>> Linux v6.16 built with dynamic ftrace randomly oops or triggers
>>> ftrace_bug() on Sophgo SG2042 when booting systemd-based userspace,
> ...
>
>>> Not sure either reverting the commits or fixing them up is a better
>>> idea, but anyway the fatal first issue shouidn't go into the stable
>>> release.
>> Let's fix this, we were expecting issues with dynamic ftrace :)
>>
>> So the following diff fixes all the issues you mentioned (not the first
>> crash though, I'll let you test and see if it works better, I don't have
>> this board):
> Thanks for the fix! I've tested it with both QEMU and SG2042, it does
> fix the lockdep failures as well as the boot time crash on SG2042. The
> boot-time crash is caused by the race so will disappear as long as we
> fix the race.
>
>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>> index 4c6c24380cfd9..97ced537aa1e0 100644
>> --- a/arch/riscv/kernel/ftrace.c
>> +++ b/arch/riscv/kernel/ftrace.c
>> @@ -14,6 +14,16 @@
>>   #include <asm/text-patching.h>
>>
>>   #ifdef CONFIG_DYNAMIC_FTRACE
>> +void ftrace_arch_code_modify_prepare(void)
>> +{
>> +       mutex_lock(&text_mutex);
>> +}
>> +
>> +void ftrace_arch_code_modify_post_process(void)
>> +{
>> +       mutex_unlock(&text_mutex);
>> +}
>> +
>>   unsigned long ftrace_call_adjust(unsigned long addr)
>>   {
>>          if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
>> @@ -29,10 +39,8 @@ unsigned long arch_ftrace_get_symaddr(unsigned long
>> fentry_ip)
>>
>>   void arch_ftrace_update_code(int command)
>>   {
>> -       mutex_lock(&text_mutex);
>>          command |= FTRACE_MAY_SLEEP;
>>          ftrace_modify_all_code(command);
>> -       mutex_unlock(&text_mutex);
>>          flush_icache_all();
>>   }
>>
>> @@ -149,16 +157,17 @@ int ftrace_init_nop(struct module *mod, struct
>> dyn_ftrace *rec)
>>          unsigned int nops[2], offset;
>>          int ret;
>>
>> +       mutex_lock(&text_mutex);
> Besides using the guard API, could we swap the order between
> ftrace_rec_set_nop_ops() and calculation of the nops array? This shrinks
> the critical region a little.


If you don't mind, I won't, I don't like initializing stuff which could 
never be used in case of error.


>
> With or without the change, here's my tag,
>
> Tested-by: Yao Zi <ziyao@disroot.org>
>
> and also
>
> Reported-by: Han Gao <rabenda.cn@gmail.com>
> Reported-by: Vivian Wang <wangruikang@iscas.ac.cn>
>
> for their first-hand report of boot-time crash and analysis for the
> first lock issue.


I'll add all those tags in the patch I'll send today (or tomorrow if the 
CI is slow).

Thanks again for the great bug report, really appreciated.

Alex


>
> Regards,
> Yao Zi
>
>>          ret = ftrace_rec_set_nop_ops(rec);
>>          if (ret)
>> -               return ret;
>> +               goto end;
>>
>>          offset = (unsigned long) &ftrace_caller - pc;
>>          nops[0] = to_auipc_t0(offset);
>>          nops[1] = RISCV_INSN_NOP4;
>>
>> -       mutex_lock(&text_mutex);
>>          ret = patch_insn_write((void *)pc, nops, 2 * MCOUNT_INSN_SIZE);
>> +end:
>>          mutex_unlock(&text_mutex);
>>
>>          return ret;
>>
>> Andy is also taking a look, I'll let him confirm the above fix is correct.
>>
>> Thanks for the thorough report!
>>
>> Alex
>>
>>
>>> Thanks for your suggestions on the problems.
>>>
>>> Regards,
>>> Yao Zi
>>>
>>> [1]: https://lore.kernel.org/all/20250407180838.42877-1-andybnac@gmail.com/
>>>
>>> #regzbot introduced: 881dadf0792c
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
