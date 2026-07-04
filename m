Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C5246762;
	Sat,  4 Jul 2026 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783176456; cv=none; b=PpHIfsyzWdiJy187mOh0Sta8kRxEI3DeqEzxNIExbPyXr4Wf673allBal8lNdqvFZld4yblYGByaGjUuZESfBiiiC1fgKP+vs6bwQW7CP9FR+BFoLqmy2cfQRU7SqiR7NHX1aQWde3bFVgjO0rGM4mnDI0ztqoSolOjlEWpT5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783176456; c=relaxed/simple;
	bh=oLmHVmiiz3zbJeL3anHiboUy/615QuDnTKNatkZtSY4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WrX7TZ+Xk320UE7gCEfNQrRptS0OmiO0CExSySrQG3Bh0InVhjKVZ0Eg/5I6e6oxKTVv6o8o36DDZVaEgMbP0xRaJQKhYXWzxDdk04M/Mp4lbKUYTfZuO5o8gOTlfwvQik90TZQve1rjWOJdOjBV3QRyppyn2obyk4joLyFD1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSEc6BT+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSEc6BT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7528D1F00A3A;
	Sat,  4 Jul 2026 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783176455;
	bh=+I/WnwI4brAJvUkUNNsBltfUHLQpGgvBdsLqClF3mvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JSEc6BT+xL6E8Q99P5Q6yjxXDxYvDwWcaNXBcOFslW7noYfOhYBks8SmBnXmfXrHn
	 TZghAGS1TUi5SWfPm5iLDbXobb6PzSNr0JdKge7G7Fy7vmOlGK65cVzAFHhWWT4tRx
	 gEk7znUn1DxFqJ07XFrTdr87z2IU/jdyBY9+Kdyml096qOJgBtqPx7lz2uQO+IRwx+
	 5vgycX+066RKhrkdV/gqufFvixBSXPQ76j3Lk7muQAIaQPz47sBI5trcxTieU2pOAy
	 hvFyOnnSJHFIHh9SrSGXv9y1wdDyBo3bTml5NdZ725MJnzBcbRJMSjS3EjTAQ1VuD1
	 3CPO4aHN2hT6w==
Date: Sat, 4 Jul 2026 23:47:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Pu Hu <hupu@transsion.com>
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
 <will@kernel.org>, "naveen@kernel.org" <naveen@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "yang@os.amperecomputing.com"
 <yang@os.amperecomputing.com>, Hongyan Xia <hongyan.xia@transsion.com>,
 Jiazi Li <jiazi.li@transsion.com>, "ada.coupriediaz@arm.com"
 <ada.coupriediaz@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC 0/2] arm64: kprobes: Fix single-step fault and reentry
 handling
Message-Id: <20260704234730.46d51c47d75e7d208e7bec9f@kernel.org>
In-Reply-To: <89c389ad-7e80-463b-9c1a-31a2e7dae814@transsion.com>
References: <20260701121448.3926-1-hupu@transsion.com>
	<20260701224345.c3a215ece3660a0cbae67645@kernel.org>
	<ec11e9ca-ae7c-49c3-ae7b-47a70e9f86af@transsion.com>
	<a6504443-8708-4f6b-819f-2052615d37df@transsion.com>
	<89c389ad-7e80-463b-9c1a-31a2e7dae814@transsion.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Pu Hu,

Can you update this by rebasing on top of arm64 tree
(git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git)
and update your signed-off-by with your name.

Thank you,

On Thu, 2 Jul 2026 10:09:51 +0000
Pu Hu <hupu@transsion.com> wrote:

> On 7/2/2026 6:07 PM, hupu wrote:
> > On 7/1/2026 9:56 PM, Pu Hu wrote:
> >> On 7/1/2026 9:43 PM, Masami Hiramatsu wrote:
> >>> On Wed, 1 Jul 2026 12:14:54 +0000
> >>> Pu Hu <hupu@transsion.com> wrote:
> >>>
> >>>> From: hupu <hupu@transsion.com>
> >>>>
> ...
> ...>
> > I will send the complete test case in a follow-up email.
> > 
> > Thanks,
> > hupu
> > 
> 
> Hi maintainers,
> 
> As mentioned in my previous email, below is the complete test case I 
> used to reproduce the arm64 kprobe crash on mainline.
> 
> It contains:
> 
>    - a small kprobe module that probes folio_wait_bit_common()
>    - a userspace program that repeatedly triggers file-backed page faults
>    - a Makefile to build both parts
> 
> Depending on the local build environment, the following variables in the
> Makefile may need to be adjusted:
> 
>      CROSS_COMPILE
>      KERN_DIR
>      DEST_PATH
> 
> Thanks,
> Pu Hu
> 
> ---
> 
> 
> diff --git a/misc/kprobe/Makefile b/misc/kprobe/Makefile
> new file mode 100755
> index 0000000..14c00c0
> --- /dev/null
> +++ b/misc/kprobe/Makefile
> @@ -0,0 +1,36 @@
> +PWD                            := $(shell pwd)
> +ARCH                   ?= arm64
> +CROSS_COMPILE  ?= aarch64-dumpstack-linux-gnu-
> +KERN_DIR               ?= $(PWD)/../../output/build-mainline
> +DEST_PATH              ?= $(PWD)/../../output
> +Q                              := @
> +
> +UNIT_TEST              := fault_stress
> +UNIT_TEST_SRC  := fault_stress.c
> +
> +KP_MOD                 := kp_folio
> +obj-m                  := $(KP_MOD).o
> +
> +USER_CFLAGS            := -static -g -O0 -fno-omit-frame-pointer 
> -fasynchronous-unwind-tables
> +USER_LIBS              := -lm -lpthread
> +EXTRA_CFLAGS   += -I$(KERN_DIR)
> +
> +.PHONY: all modules user clean
> +
> +all: modules user install
> +
> +modules:
> +       $(Q)$(MAKE) -C $(KERN_DIR) M=$(PWD) 
> EXTRA_CFLAGS="$(EXTRA_CFLAGS)" ARCH=$(ARCH) 
> CROSS_COMPILE=$(CROSS_COMPILE) modules
> +
> +user:
> +       $(Q)$(CROSS_COMPILE)gcc $(USER_CFLAGS) $(UNIT_TEST_SRC) -o 
> $(UNIT_TEST) $(USER_LIBS)
> +
> +install:
> +       $(Q)mkdir -p $(DEST_PATH)
> +       $(Q)cp -f *.ko $(DEST_PATH)/
> +       $(Q)cp -f $(UNIT_TEST) $(DEST_PATH)/
> +
> +clean:
> +       $(Q)$(MAKE) -C $(KERN_DIR) M=$(PWD) clean
> +       $(Q)rm -f $(UNIT_TEST)
> +       $(Q)rm -f $(DEST_PATH)/$(UNIT_TEST) $(DEST_PATH)/*.ko
> diff --git a/misc/kprobe/fault_stress.c b/misc/kprobe/fault_stress.c
> new file mode 100755
> index 0000000..10150ff
> --- /dev/null
> +++ b/misc/kprobe/fault_stress.c
> @@ -0,0 +1,96 @@
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define FILE_SIZE   (256UL * 1024 * 1024)
> +#define NR_THREADS  8
> +
> +static void deep_call(int n)
> +{
> +       volatile char buf[4096];
> +
> +       memset((void *)buf, n, sizeof(buf));
> +
> +       if (n > 0)
> +               deep_call(n - 1);
> +       else
> +               sched_yield();
> +}
> +
> +static void *worker(void *arg)
> +{
> +       const char *path = arg;
> +       int fd;
> +       char *map;
> +       unsigned long i;
> +       volatile unsigned long sum = 0;
> +
> +       fd = open(path, O_RDONLY);
> +       if (fd < 0) {
> +               perror("open");
> +               return NULL;
> +       }
> +
> +       map = mmap(NULL, FILE_SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
> +       if (map == MAP_FAILED) {
> +               perror("mmap");
> +               close(fd);
> +               return NULL;
> +       }
> +
> +       for (;;) {
> +               /*
> +                * Drop the pages backing this mapping from the current 
> process.
> +                * Subsequent accesses are more likely to trigger 
> file-backed
> +                * page faults again.
> +                */
> +               madvise(map, FILE_SIZE, MADV_DONTNEED);
> +
> +               for (i = 0; i < FILE_SIZE; i += 4096 * 17) {
> +                       sum += map[i];
> +                       deep_call(64);
> +               }
> +       }
> +
> +       munmap(map, FILE_SIZE);
> +       close(fd);
> +       return NULL;
> +}
> +
> +int main(void)
> +{
> +       pthread_t th[NR_THREADS];
> +       const char *path = "/tmp/fault_stress_file";
> +       int fd;
> +       int i;
> +
> +       fd = open(path, O_CREAT | O_RDWR, 0644);
> +       if (fd < 0) {
> +               perror("open file");
> +               return 1;
> +       }
> +
> +       if (ftruncate(fd, FILE_SIZE) < 0) {
> +               perror("ftruncate");
> +               return 1;
> +       }
> +
> +       close(fd);
> +
> +       for (i = 0; i < NR_THREADS; i++)
> +               pthread_create(&th[i], NULL, worker, (void *)path);
> +
> +       for (i = 0; i < NR_THREADS; i++)
> +               pthread_join(th[i], NULL);
> +
> +       return 0;
> +}
> +
> diff --git a/misc/kprobe/kp_folio.c b/misc/kprobe/kp_folio.c
> new file mode 100755
> index 0000000..c8f3e1d
> --- /dev/null
> +++ b/misc/kprobe/kp_folio.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/kprobes.h>
> +#include <linux/sched.h>
> +#include <linux/atomic.h>
> +#include <linux/ratelimit.h>
> +
> +static atomic64_t kp_hit_count = ATOMIC64_INIT(0);
> +
> +static int folio_wait_bit_common_handler(
> +                       struct kprobe *p,^M
> +                       struct pt_regs *regs)
> +{
> +       unsigned long hit;
> +
> +       hit = atomic64_inc_return(&kp_hit_count);
> +
> +       pr_info("kp_folio: hit=%lu comm=%s tgid=%d tid=%d\n",
> +               hit, current->comm, current->tgid, current->pid);
> +
> +       return 0;
> +}
> +
> +static struct kprobe kp_folio_wait_bit_common = {
> +       .symbol_name = "folio_wait_bit_common",
> +       .pre_handler = folio_wait_bit_common_handler,
> +};
> +
> +static int __init kp_folio_init(void)
> +{
> +       int ret;
> +
> +       ret = register_kprobe(&kp_folio_wait_bit_common);
> +       if (ret < 0) {
> +               pr_err("kp_folio: register_kprobe failed, ret=%d\n", ret);
> +               return ret;
> +       }
> +
> +       pr_info("kp_folio: kprobe registered at %pS, addr=%px\n",
> +               kp_folio_wait_bit_common.addr,
> +               kp_folio_wait_bit_common.addr);
> +
> +       return 0;
> +}
> +
> +static void __exit kp_folio_exit(void)
> +{
> +       unregister_kprobe(&kp_folio_wait_bit_common);
> +
> +       pr_info("kp_folio: kprobe unregistered, total hits=%lld\n",
> +               atomic64_read(&kp_hit_count));
> +}
> +
> +module_init(kp_folio_init);
> +module_exit(kp_folio_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("hupu <hupu@transsion.com>");
> +MODULE_DESCRIPTION("simple kprobe reproducer for folio_wait_bit_common");
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
