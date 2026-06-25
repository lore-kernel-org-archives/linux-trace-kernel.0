Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31222332604
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371734; cv=none; b=fTULL5akW/llIcywGUJIkmXW4aOXc47j9s82QMu9L/Cp9Qdmzp11ZNgiZUtad3hHs3aeYX2+/tOT7EvrjIXxzbteZbAN/IPjcT2f/O9stXzbompvxLR17qIeoTd8IFMODKDcJ1xQcsJ19f1RhKf7m4GzBTOQ2iFWi//fARXTOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371734; c=relaxed/simple;
	bh=u8XCrqCgJetvR2xdyVexEcnDWRZXDkhW13PCWvw8OtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJFVujQiwhkul6SlseRTeTySgOuuztNbVh49WuT8xfnA2lDOXgacDZEdTAC8EHApuKxJwKIfUrSla8Qn9P+7EUmv3mKHU+LSzpcH8XkTF5eFKI6yZ84E6Ct8T+oTDEhAx1QldK09dkWAwbEjq27oBsWw+s7LbtMs4fc8LKimkco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G4Jv8KrS; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G4Jv8KrS"
X-Forwarded-Encrypted: i=1; AFNElJ/zIXfKQttLMWqc7hdzs3j8Jdc5cqPHy6Vam1p3h9wASIuMinzgV4MbIhq13L+OpvCEwrvjCB2MNRejJhj0PPWUEjE=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782371730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4l8kEDpwe6ZsvCFof1KiGbqck2t2+CoEwvUDbK1yNQ=;
	b=G4Jv8KrSZoKm/h0cWk4HI8AF9Rcw5kChPmYYlIN8avju2k0n0QAuEb2b1FMW/k3KLn88he
	/RTmhOMbtkTBI+XHZCRwtlBEFo9D4Lv++ycf8ONtLq+eLg98Pm5QbUy2Urr+TFgFOOSn27
	mlyQoQ2rnhtIGZtyZ/ZIrUAAma3+850=
X-Gm-Message-State: AOJu0YwXHUSPsVW/TiNGDOpbS2k6IdtUYoOQtadA4mZ+eYfBtx5YFdL1
	2iI6wfzOeKFUGc93MgZRPt8DkCmz6MhDjXLVFuVQsaSHOFN0wIiNhEP+VxaAk4uMwhaq+oByrgc
	yhBfTFontHDTRqoePys0yART2FAuep3OvqVdG4p4/
X-Received: by 2002:a05:622a:1f96:b0:516:cc18:4760 with SMTP id
 d75a77b69052e-51a709958aamr5225201cf.21.1782371725540; Thu, 25 Jun 2026
 00:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-37-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-37-9d2959357853@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 25 Jun 2026 08:14:48 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxZQf9w+iT11O3+KC-z6Sbg5qCEZ-XCR3=wRnG2k3=Maw@mail.gmail.com>
X-Gm-Features: AVVi8Cfiom8KyzZV2HmAlpy9PB5CRyn77LPV2Q5_VbhfHk5a3YCLzvyw4gtaMNM
Message-ID: <CA+EHjTxZQf9w+iT11O3+KC-z6Sbg5qCEZ-XCR3=wRnG2k3=Maw@mail.gmail.com>
Subject: Re: [PATCH v8 37/46] KVM: selftests: Test that shared/private status
 is consistent across processes
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Fri, 19 Jun 2026 at 01:32, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Add a test to verify that a guest_memfd's shared/private status is
> consistent across processes, and that any shared pages previously mapped in
> any process are unmapped from all processes.
>
> The test forks a child process after creating the shared guest_memfd
> region so that the second process exists alongside the main process for the
> entire test.
>
> The processes then take turns to access memory to check that the
> shared/private status is consistent across processes.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---

Two things below, otherwise:

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>  .../kvm/x86/guest_memfd_conversions_test.c         | 118 +++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index f03af2c46426f..99b0023609670 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> @@ -2,6 +2,8 @@
>  /*
>   * Copyright (c) 2024, Google LLC.
>   */
> +#include <pthread.h>
> +#include <time.h>
>  #include <sys/mman.h>
>  #include <unistd.h>

nit: include order

>
> @@ -323,6 +325,122 @@ GMEM_CONVERSION_TEST_INIT_SHARED(truncate)
>         test_private(t, 0, 0, 'A');
>  }
>
> +/* Test that shared/private memory protections work and are seen from any process. */
> +GMEM_CONVERSION_TEST_INIT_SHARED(forked_accesses)
> +{
> +       enum test_state {
> +               STATE_INIT,
> +               STATE_CHECK_SHARED,
> +               STATE_DONE_CHECKING_SHARED,
> +               STATE_CHECK_PRIVATE,
> +               STATE_DONE_CHECKING_PRIVATE,
> +       };
> +
> +       struct sync_state {
> +               pthread_mutex_t mutex;
> +               pthread_cond_t cond;
> +               enum test_state step;
> +       } *sync;
> +
> +       pthread_mutexattr_t mattr;
> +       pthread_condattr_t cattr;
> +       pid_t child_pid, parent_pid;
> +       int status;
> +
> +       sync = kvm_mmap(sizeof(*sync), PROT_READ | PROT_WRITE,
> +                       MAP_SHARED | MAP_ANONYMOUS, -1);
> +
> +       pthread_mutexattr_init(&mattr);
> +       pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_SHARED);
> +       pthread_mutex_init(&sync->mutex, &mattr);
> +       pthread_mutexattr_destroy(&mattr);
> +
> +       pthread_condattr_init(&cattr);
> +       pthread_condattr_setpshared(&cattr, PTHREAD_PROCESS_SHARED);
> +       pthread_cond_init(&sync->cond, &cattr);
> +       pthread_condattr_destroy(&cattr);
> +
> +       sync->step = STATE_INIT;
> +
> +#define TEST_STATE_AWAIT(__state)                                              \
> +       do {                                                                    \
> +               pthread_mutex_lock(&sync->mutex);                               \
> +               while (sync->step != (__state)) {                               \
> +                       struct timespec ts, stop;                               \
> +                       int ret;                                                \
> +                                                                               \
> +                       clock_gettime(CLOCK_REALTIME, &ts);                     \
> +                       stop = timespec_add_ns(ts, 100 * 1000000UL);            \
> +                                                                               \
> +                       ret = pthread_cond_timedwait(&sync->cond, &sync->mutex, &stop); \
> +                       if (ret == ETIMEDOUT) {                                 \
> +                               bool alive = (child_pid == 0) ?                 \
> +                                            (getppid() == parent_pid) :                \
> +                                            (waitpid(child_pid, NULL, WNOHANG) == 0); \

Not sure it's worth it, but if you want to silence Sashiko, waitid
with WNOWAIT might be the way to go (not tested, just from looking at
the man page). This is though very unlikely, mentioning it since
Sashiko complained.


> +                               TEST_ASSERT(alive, "Other process exited prematurely"); \
> +                       } else {                                                \
> +                               TEST_ASSERT(!ret, "pthread_cond_timedwait failed"); \
> +                       }                                                       \
> +               }                                                               \
> +               pthread_mutex_unlock(&sync->mutex);                             \
> +       } while (0)
> +
> +#define TEST_STATE_SET(__state)                                                        \
> +       do {                                                                    \
> +               pthread_mutex_lock(&sync->mutex);                               \
> +               sync->step = (__state);                                         \
> +               pthread_cond_broadcast(&sync->cond);                            \
> +               pthread_mutex_unlock(&sync->mutex);                             \
> +       } while (0)
> +
> +       parent_pid = getpid();
> +       child_pid = fork();
> +       TEST_ASSERT(child_pid != -1, "fork failed");
> +
> +       if (child_pid == 0) {
> +               const char inconsequential = 0xdd;
> +
> +               TEST_STATE_AWAIT(STATE_CHECK_SHARED);
> +
> +               /*
> +                * This maps the pages into the child process as well, and tests
> +                * that the conversion process will unmap the guest_memfd memory
> +                * from all processes.
> +                */
> +               host_do_rmw(t->mem, 0, 0xB, 0xC);
> +
> +               TEST_STATE_SET(STATE_DONE_CHECKING_SHARED);
> +               TEST_STATE_AWAIT(STATE_CHECK_PRIVATE);
> +
> +               TEST_EXPECT_SIGBUS(READ_ONCE(t->mem[0]));
> +               TEST_EXPECT_SIGBUS(WRITE_ONCE(t->mem[0], inconsequential));
> +
> +               TEST_STATE_SET(STATE_DONE_CHECKING_PRIVATE);
> +               exit(0);
> +       }
> +
> +       test_shared(t, 0, 0, 0xA, 0xB);
> +
> +       TEST_STATE_SET(STATE_CHECK_SHARED);
> +       TEST_STATE_AWAIT(STATE_DONE_CHECKING_SHARED);
> +
> +       test_convert_to_private(t, 0, 0xC, 0xD);
> +
> +       TEST_STATE_SET(STATE_CHECK_PRIVATE);
> +       TEST_STATE_AWAIT(STATE_DONE_CHECKING_PRIVATE);
> +
> +       TEST_ASSERT_EQ(waitpid(child_pid, &status, 0), child_pid);
> +       TEST_ASSERT(WIFEXITED(status) && WEXITSTATUS(status) == 0,
> +                   "Child exited with unexpected status");
> +
> +       pthread_mutex_destroy(&sync->mutex);
> +       pthread_cond_destroy(&sync->cond);
> +       kvm_munmap(sync, sizeof(*sync));
> +
> +#undef TEST_STATE_SET
> +#undef TEST_STATE_AWAIT
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
