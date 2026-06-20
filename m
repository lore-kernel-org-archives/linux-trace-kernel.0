Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153141C6A;
	Sat, 20 Jun 2026 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781998297; cv=none; b=YzuKnqWjmtSLufixlHINQbqauy1oa1MYq9mWLlyzAS3I8q9i7bewqSISymyo/93t26Rn6nR47XeuuuPXASY33F3Hm+N2Qlb2QbpcpL4oV+jN26c/T141P6raRJn+8wmrJUVDTULrtT6/g/ITnzs/e7Aq9Vs1nJjnZs05XVSQJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781998297; c=relaxed/simple;
	bh=Q93/bPH8qL2ugM7eUmujWJ8CXjb5qKRitiMD/DJXWNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onJFHCgWczXbFjpgx5XPQ+m7FCfISaSuF2qy62sUcLqX4kkwdrhsqTEpQfAEQdIeq1xtO8Ts+j89rD9P2VmcFg9W11g/YtTgME2rFrcA5J32ZFktR91hUdJs/9YfoC1DgOYQ54bv7YkuPSLCDVK9HoXIddG/LBL8fyI80+JGIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gUb9lt7V; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gUb9lt7V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781998289; bh=L0ocVSj1iSiYTCtToyZ3/RrYTG6QU1W0rohHrlyLT+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gUb9lt7V/nXlESp+1YP87sbusym9/PFEES6ZvtDAEnowRKsAON4c3oeMLb6jaQM6g
	 AkZPJRJm+osCFYKtYrauvaYtwpNDw0WS772evHcmO1hvOGNQy88V0Matd9Rjji0gDC
	 6IHtO7yylHKiWXwzl5GP86YcmMyzJJqtay7wpV2k=
Received: from [192.168.1.100] ([183.94.22.181])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 788322E2; Sun, 21 Jun 2026 07:30:08 +0800
X-QQ-mid: xmsmtpt1781998208tbgwjv0dx
Message-ID: <tencent_913194D0B2365EB0E404E464443D38FDC607@qq.com>
X-QQ-XMAILINFO: OZMlMiGBv3y9jnqjZMVbgiFXJL1sWqAPMVb3D6VzpCUzNMm8ozNLmLMIga5cU7
	 hNfrCpxrMxiADLAYdIrUSsftE0h1syis66b0XET/aT6NJhfwr3AvhZrX5y6mU7T+lJ43t689gAqi
	 eiHMy4cHRunBrNBA/PTYgeRebUF4T/+jkmKACLMCvzWKESNbnNIRmYOWwmY9MpWbBYsk+DKA/Sa4
	 DGzlubnKxolRjyjs7Cv92It+tYG8ma1Tm+7K/aMzjxp/lZ7buP7nYbiztumvf4C8JxOUt1z3a1+U
	 QlUA2ajjOqQQqwWF8Jhma0StvGGYjHPxvIebwcfEcyeHmdbvT/jymouWvL/aoVOm5v3TvQMG53kj
	 43uUM7iY/UpVoiI8Q1vb1/i+FfP7eOu2CojkED2Z+QUUhdxPQhtWuCU2PHa+d+nEmzDVDxAgSASm
	 OrB5lzO4qjjm17riesuZddWnVcYpdvHXJYz9vyGt594XQKLrw6iNtbWzmGb5ryo/Uencsh3VgjwL
	 0ForULkqrAe2LTtSCxzViTAPlCvVCgO0q2pHeoT35ODFY5J1oAfwTnZuw02tESk0NHB0yyMn5vmp
	 zlWfALbxpRlJ8cmmfkGD4gzTR3R7MnzG9F7vzUbFNi4GeQCpAb/9o3srnd8agsLhBAVg8SlJh99u
	 6IcAirUjd8JoyrXk7Ew5StvNqRNClF33+wgVJww+VdsGxrP9bzImEVepK9XqxSpi0uDMMfwsMlq2
	 8m8Uez9NUQ0WpSsuuqs4F/SGXMLtbMOYvlMvaOI8h6bABYZJY3dy8t2ZnA62XB/EF3eR01k6a3in
	 fa9k9qLfT+tN8tJ0vmpKQMlNGkChISelGishaON4vFaPXIBb92RVUxHnTzkC+sakAr43lUDQycqG
	 dU0Gl6Zc3RQtbcUFV2g8XOhHuJPp2+7ZOfhbj147BsDZeGnWe+vB9eqEh0+7rfg+EMiK1pYxOOQV
	 xTKNRzKLeMW6jk+EsU8AuXCTcF1VU1FaEc5ffsfLll0dFjXo8BZeF6RHJftGj1iPCZe7gi+7OB8b
	 kQ6Ln6Opv4GqZyunALSjCbQh5YTlk9Vp2ujcCHl0O8jzVvWSPuGbAQaDGIzmc=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-OQ-MSGID: <78460bd2-e399-4620-a540-45662fc83b95@qq.com>
Date: Sun, 21 Jun 2026 07:30:08 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rv/reactors: add KUnit tests for reactor_panic
To: wen.yang@linux.dev, Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1781541556.git.wen.yang@linux.dev>
 <810f587d63c84b64067f990299be02b88f5d8106.1781541556.git.wen.yang@linux.dev>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <810f587d63c84b64067f990299be02b88f5d8106.1781541556.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Wen,

I came across a Sashiko AI code review [1] that flagged a potential NULL
pointer dereference in the `test_panic_register_unregister()` test case
added by this patch (commit 8655782285e2).  The review's analysis seemed
plausible, so I spun up a QEMU environment to see whether it could be
reproduced in practice.

The short version: yes, it triggers a real kernel BUG + Oops.  See below
for the crash log and the reproduction approach.

On Tue, 16 Jun 2026 at 00:44, Wen Yang wrote:
 > Add KUnit tests for the panic reactor covering:
 > - Reactor registration and unregistration lifecycle
 > - Panic notifier chain reachability
...
 > +static void test_panic_register_unregister(struct kunit *test)
 > +{
 > +    int ret;
 > +
 > +    ret = rv_register_reactor(&mock_panic_reactor);
 > +    KUNIT_EXPECT_EQ(test, ret, 0);
 > +    KUNIT_EXPECT_STREQ(test, mock_panic_reactor.name, "test_panic");
 > +
 > +    rv_unregister_reactor(&mock_panic_reactor);

This is the function the review highlighted.  The issue is:

   - `KUNIT_EXPECT_EQ()` does *not* abort the test on failure.
   - If `rv_register_reactor()` fails (e.g. because another reactor
     named "test_panic" was already registered), the .list node of the
     statically-allocated `mock_panic_reactor` is never added to any
     list — it remains zero-initialized (prev = NULL, next = NULL).
   - `rv_unregister_reactor()` then unconditionally calls `list_del()`
     on this uninitialized list_head, which hits the NULL pointers.

I was able to reproduce this reliably.  The trigger condition is
surprisingly simple: if any code path registers a reactor named
"test_panic" before the KUnit suite runs, the test crashes the kernel.

[Reproduction approach]

I rebuilt the kernel with a small late_initcall in rv_reactors.c that
pre-registers "test_panic" (simulating what would happen if, say, a
kernel module or another subsystem registered a reactor with the same
name before the KUnit tests execute):

   static int __init prereg_test_panic(void)
   {
       static struct rv_reactor prereg = {
           .name = "test_panic",
           .description = "pre-registered to simulate name collision",
       };
       return rv_register_reactor(&prereg);
   }
   late_initcall(prereg_test_panic);

The KUnit tests then auto-run at boot (kunit_run_all_tests).  The
test_panic_register_unregister case fails registration with -EINVAL due
to the duplicate name, the KUNIT_EXPECT_EQ does not abort, and
rv_unregister_reactor() crashes on the uninitialized list.

[Crash log — kernel 7.1.0-next-20260615, CONFIG_DEBUG_LIST=y]

   Reactor test_panic is already registered
       # test_panic_register_unregister: EXPECTATION FAILED at 
kernel/trace/rv/reactor_panic_kunit.c:68
       Expected ret == 0, but
           ret == -22 (0xffffffffffffffea)
   list_del corruption, ffffffff8ecce2f8->next is NULL
   ------------[ cut here ]------------
   kernel BUG at lib/list_debug.c:52!
   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
   CPU: 1 UID: 0 PID: 5028 Comm: kunit_try_catch Tainted: G   N
   RIP: 0010:__list_del_entry_valid_or_report+0xf2/0x200
   Call Trace:
    <TASK>
    rv_unregister_reactor+0x37/0x190
    test_panic_register_unregister+0x1de/0x2e0
    kunit_try_run_case+0x1d2/0x520
    kunit_generic_run_threadfn_adapter+0x89/0x100
    kthread+0x387/0x4a0
    ret_from_fork+0xb2c/0xdd0
    </TASK>
   Kernel panic - not syncing: Fatal exception

The crash is in `rv_unregister_reactor()`, called from
`test_panic_register_unregister()`.  The `list_del()` in
`rv_unregister_reactor()` has no guard against a list node that was
never added to any list.  With CONFIG_DEBUG_LIST=y the corruption is
caught explicitly; without it this would be a silent NULL dereference.

[Suggested fix]

The most straightforward fix is to use `KUNIT_ASSERT_EQ()` instead of
`KUNIT_EXPECT_EQ()` for the registration result, so the test aborts
before reaching `rv_unregister_reactor()` on a failed registration:

   static void test_panic_register_unregister(struct kunit *test)
   {
       int ret;

       ret = rv_register_reactor(&mock_panic_reactor);
-     KUNIT_EXPECT_EQ(test, ret, 0);
+     KUNIT_ASSERT_EQ(test, ret, 0);
       KUNIT_EXPECT_STREQ(test, mock_panic_reactor.name, "test_panic");

       rv_unregister_reactor(&mock_panic_reactor);
   }

An alternative (or complementary) approach would be to add a guard in
`rv_unregister_reactor()` itself — e.g. checking whether the reactor is
actually on the list before calling `list_del()`.  That would make the
API more robust against future callers making the same mistake.

The same pattern likely applies to the printk reactor tests in patch
2/3, though I haven't tested those.

Full PoC code follows.

[PoC part 1 — Kernel-space: late_initcall to create the name collision]

This is what was added to kernel/trace/rv/rv_reactors.c (or could be
built as a standalone kernel module — see preregister.c below).  It
pre-registers "test_panic" before KUnit auto-runs, so the test's own
rv_register_reactor() fails with -EINVAL:

   static int __init prereg_test_panic(void)
   {
       static struct rv_reactor prereg = {
           .name = "test_panic",
           .description = "pre-registered to simulate name collision",
       };
       return rv_register_reactor(&prereg);
   }
   late_initcall(prereg_test_panic);

[PoC part 2 — Userspace: trigger the KUnit test via debugfs]

poc.c:
---8<----------------------------------------------------------------
/*
  * POC: NULL pointer dereference in rv_unregister_reactor()
  *
  * Bug location: kernel/trace/rv/reactor_panic_kunit.c
  *   test_panic_register_unregister()
  *
  * Bug: When rv_register_reactor() fails (because "test_panic" is already
  * registered), the test calls rv_unregister_reactor() unconditionally.
  * This performs list_del() on a zero-initialized list_head (never added
  * to any list), causing a NULL pointer dereference crash.
  *
  * Trigger: With a kernel that has pre-registered "test_panic" reactor,
  * simply trigger the KUnit test via debugfs "run" file. The test's
  * rv_register_reactor() fails with -EINVAL (duplicate), and the subsequent
  * rv_unregister_reactor() crashes on the uninitialized list.
  */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

#define KUNIT_RUN_PATH "/sys/kernel/debug/kunit/rv_reactor_panic/run"

int main(int argc, char **argv)
{
     int fd, ret;

     setbuf(stdout, NULL);

     printf("[+] POC: Triggering NULL deref in rv_unregister_reactor\n");
     printf("[+] Target: %s\n\n", KUNIT_RUN_PATH);

     /* Mount debugfs if needed */
     if (access("/sys/kernel/debug", F_OK) != 0) {
         printf("[*] Mounting debugfs...\n");
         ret = system("mount -t debugfs none /sys/kernel/debug/ 
2>/dev/null");
         (void)ret;
     }

     /* Verify KUnit path exists */
     if (access(KUNIT_RUN_PATH, W_OK) != 0) {
         printf("[-] Cannot access %s: %m\n", KUNIT_RUN_PATH);
         printf("[*] Available KUnit suites:\n");
         fflush(stdout);
         system("ls -la /sys/kernel/debug/kunit/ 2>&1");
         return 1;
     }

     printf("[*] Test_panic reactor should be pre-registered at boot\n");
     printf("[*] Triggering KUnit test suite...\n\n");

     /*
      * Write to the KUnit run file. This executes
      * __kunit_test_suites_init() -> kunit_run_tests() which
      * runs the reactor_panic_kunit test cases including
      * test_panic_register_unregister.
      *
      * With "test_panic" pre-registered:
      * 1. rv_register_reactor() returns -EINVAL (duplicate)
      * 2. KUNIT_EXPECT_EQ doesn't abort
      * 3. rv_unregister_reactor() calls list_del() on NULL list
      * 4. BOOM: list corruption / NULL deref / kernel crash
      */
     fd = open(KUNIT_RUN_PATH, O_WRONLY);
     if (fd < 0) {
         printf("[-] open failed: %m\n");
         return 1;
     }

     printf("[!] Writing to %s - triggering the crash now...\n", 
KUNIT_RUN_PATH);
     fflush(stdout);

     ret = write(fd, "1", 1);
     if (ret < 0) {
         printf("[-] write failed: %m\n");
     } else {
         printf("[+] Write succeeded (ret=%d)\n", ret);
     }

     close(fd);

     /*
      * If we reach here without crashing, let the user know
      */
     printf("\n[*] If the system is still alive, check dmesg:\n");
     printf("    dmesg | grep -i -E 
'list_del|list_add|list_corrupt|NULL|BUG|oops\n");
     printf("\n[*] dmesg output:\n");
     fflush(stdout);
     system("dmesg | tail -60");

     printf("\n[+] POC completed.\n");

     return 0;
}
---8<----------------------------------------------------------------

Compile with:
   gcc -o poc poc.c -static

[PoC part 3 — Kernel module alternative (standalone)]

If you prefer not to modify rv_reactors.c directly, the same name
collision can be created by loading this module before running the
KUnit test.  Note: this requires rv_register_reactor() to be exported
(or resolved via kallsyms), which it may not be in the current tree.
In that case the late_initcall approach above is the way to go.

preregister.c:
---8<----------------------------------------------------------------
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/rv.h>

static struct rv_reactor prereg_reactor = {
     .name = "test_panic",
     .description = "pre-registered to trigger KUnit bug",
};

static int __init prereg_init(void)
{
     int ret;
     ret = rv_register_reactor(&prereg_reactor);
     if (ret < 0) {
         pr_err("preregister: rv_register_reactor failed: %d\n", ret);
         return ret;
     }
     pr_info("preregister: registered 'test_panic' reactor\n");
     return 0;
}

static void __exit prereg_exit(void)
{
     rv_unregister_reactor(&prereg_reactor);
     pr_info("preregister: unregistered 'test_panic' reactor\n");
}

module_init(prereg_init);
module_exit(prereg_exit);
MODULE_LICENSE("GPL");
---8<----------------------------------------------------------------


[1] https://sashiko.dev/#/patchset/cover.1781541556.git.wen.yang%40linux.dev
     (Sashiko AI code review — "Null Pointer Dereference", Severity: High)

Thanks,
XIAO

