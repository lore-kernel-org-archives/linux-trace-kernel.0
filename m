Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699464;
	b=d7+EjfF01Y3Age3NYpfKtqGUOQEeqbFW6Mo3i8QFoDguMvenfm6vDpFCehrnkDESacIF
	 8zrrzFkJGBpXj3wilfdsAijrF6Dpz2X3cq3an/HUgdyM425WlUa+JW0dMNJvD5KGRji96
	 WXz2HQs/iRD5PmovNH7OZHFklrHYc7DJ8NUI40FFPkkg/6s0mpqBCL+4Jk/1NHsZO6q0J
	 1yDE36yJPIJ7B7mrE3OdH5HiMp6p4sKpR0VhllTiSmesVQM7nPXYjFNNno/8gyTZrrR0N
	 H5mJSEDhaK/oJq0BsLrt7XDL2dqY7dwgxKTk13yf7X59KltEEO++ez5nWQtjfEjSOMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699464;
	h=DMARC-Filter:Received:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:
	 X-CM-SenderInfo;
	bh=9Ytf/hgVA5s6xuBkEZhEYc5g21hKogJ9a5/6yr9VeuA=;
	b=as543yLrsgFhZZB8kXU8akzOTxrJ58MmC/oe59sFTwO+du3J1rDDC7bbhgVo+/aQJh6D
	 +lYpHwcRBqfBcZ4bb0vub2niRmItigtg2oatXJJyyLnYnyjRvxA13PO+JAXmkDjjtqhzB
	 fBSLJOUX2yKecmKSV6Qfl73WtIhQB7DhvNOYy2re3oU+a8g3ZSB5AYp8lqo4kU2ejWK2S
	 XDNLH7xPP20+2K3f4+a460Q6ElHA9ErZAlv1mACzLU6H23VoqnyHulQ7tPWKB+2+4iSRa
	 P38sAuIaDTFL0Mmok7KSM/1bT8+cQEdl4hPr+sVLDZ55Iq0zdV1s6KtXIVgZ492MWRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD7606A333;
	Tue,  3 Nov 2026 09:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CBD7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [121.237.245.232])
	by APP-05 (Coremail) with SMTP id zQCowAAHobZ_rulqo_g+AA--.1625S2;
	Tue, 03 Nov 2026 17:50:55 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v2] uprobes: Restore original return address in uretprobe
 context
From: daichengrong <daichengrong@iscas.ac.cn>
In-Reply-To: <20260810080140.96587-1-daichengrong@iscas.ac.cn>
Date: Tue, 3 Nov 2026 16:58:03 +0800
Cc: linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 alex@ghiti.fr,
 Albert Ou <aou@eecs.berkeley.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <313E1182-DADD-485A-AE2C-36ACA58F35DE@iscas.ac.cn>
References: <20260810080140.96587-1-daichengrong@iscas.ac.cn>
To: Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-CM-TRANSID:zQCowAAHobZ_rulqo_g+AA--.1625S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArWkCr1UKF4fAFy5GryrCrg_yoWrXrWkpa
	1vka43KFWDG34UuFZxXr45Z3WFvrZ5Xw47Cr1xK34fC345KryxJw1I93yUZF1FyrZ2gF17
	Ar4jkFWUAa9rJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1D
	MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU5iB_UUUUUU==
X-CM-SenderInfo: pgdluxxhqj201qj6x2xfdvhtffof0/

Hi,

Just a friendly ping about this patch. Any feedback or review would be =
appreciated.

Thanks!

> 2026=E5=B9=B48=E6=9C=8810=E6=97=A5 16:01=EF=BC=8Cdaichengrong =
<daichengrong@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> uretprobe replaces the original return address of a probed function =
with
> a trampoline address to capture function return events.
>=20
> After the trampoline is entered and the uretprobe handler completes, =
the
> original return address needs to be restored in the user register =
context
> to keep the register state consistent with the state before probing.
>=20
> Add an architecture-specific hook for restoring the original return
> address during uretprobe handling.
>=20
> The initial implementation adds support for RISC-V. Other =
architectures
> keep the default empty implementation until their corresponding =
restore
> logic is implemented.
>=20
> Signed-off-by: daichengrong <daichengrong@iscas.ac.cn>
> ---
> Change in v2:
> - Rename arch_uretprobe_hijack_set_addr() to =
arch_uretprobe_restore_return_address() as suggested
>=20
> v1: =
https://lore.kernel.org/all/20260717082331.27058-1-daichengrong@iscas.ac.c=
n/
> ---
> arch/riscv/kernel/probes/uprobes.c | 7 +++++++
> include/linux/uprobes.h            | 1 +
> kernel/events/uprobes.c            | 5 +++++
> 3 files changed, 13 insertions(+)
>=20
> diff --git a/arch/riscv/kernel/probes/uprobes.c =
b/arch/riscv/kernel/probes/uprobes.c
> index eb177d0ce8ab..90ed8596e73f 100644
> --- a/arch/riscv/kernel/probes/uprobes.c
> +++ b/arch/riscv/kernel/probes/uprobes.c
> @@ -139,6 +139,13 @@ arch_uretprobe_hijack_return_addr(unsigned long =
trampoline_vaddr,
> return ra;
> }
>=20
> +void
> +arch_uretprobe_restore_return_address(unsigned long orig_ret_vaddr,
> +  struct pt_regs *regs)
> +{
> + regs->ra =3D orig_ret_vaddr;
> +}
> +
> int arch_uprobe_exception_notify(struct notifier_block *self,
> unsigned long val, void *data)
> {
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index f548fea2adec..af5b633f92dd 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -230,6 +230,7 @@ extern bool arch_uprobe_xol_was_trapped(struct =
task_struct *tsk);
> extern int  arch_uprobe_exception_notify(struct notifier_block *self, =
unsigned long val, void *data);
> extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct =
pt_regs *regs);
> extern unsigned long arch_uretprobe_hijack_return_addr(unsigned long =
trampoline_vaddr, struct pt_regs *regs);
> +extern void arch_uretprobe_restore_return_address(unsigned long =
orig_ret_vaddr, struct pt_regs *regs);
> extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum =
rp_check ctx, struct pt_regs *regs);
> extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs =
*regs);
> extern void arch_uprobe_copy_ixol(struct page *page, unsigned long =
vaddr,
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 6300b216012c..9a2e9ce4e398 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1748,6 +1748,10 @@ void * __weak =
arch_uretprobe_trampoline(unsigned long *psize)
> return &insn;
> }
>=20
> +void __weak arch_uretprobe_restore_return_address(unsigned long =
orig_ret_vaddr, struct pt_regs *regs)
> +{
> +}
> +
> static struct xol_area *__create_xol_area(unsigned long vaddr)
> {
> struct mm_struct *mm =3D current->mm;
> @@ -2659,6 +2663,7 @@ void uprobe_handle_trampoline(struct pt_regs =
*regs)
> valid =3D !next_chain || arch_uretprobe_is_alive(next_chain, =
RP_CHECK_RET, regs);
>=20
> instruction_pointer_set(regs, ri->orig_ret_vaddr);
> + arch_uretprobe_restore_return_address(ri->orig_ret_vaddr, regs);
> do {
> /* pop current instance from the stack of pending return instances,
> * as it's not pending anymore: we just fixed up original
> --=20
> 2.25.1

