Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6663BBFBF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330375; cv=pass; b=brUatsYMuNBA0eOc3kkdLCysXzcUmk5nma0RKaN3gKvGejtJu6F+/mPmfTA76sMgHw67Ur6z199q3VLODpYG/QNs6yq8cdAz5HdMiEJowTllXDFRJSQyo4ETVwLjlS5axbiO66PHhPH0FEQqXB38W5rkJw0X6XYZlfJJp3i4vVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330375; c=relaxed/simple;
	bh=7HSdj2FSv112L0Qh3W+nuPO0m13LxTfz4BlfP1Hys9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CakvyuXSEBoOoo7qWIN5gw0onWALxqlBwad0tlz27CTiySOqyJFRJ7fbPYjNOGoA3PYQTN3wnkmZenEKCWIwEzwHwaIgY+mrU/0uaaSUb65QLEOtI7e9ETe2A9k2ga19fOnrc6WaYLbV/2jdOm4O4GdrwWUx3gXyoY5Wc+PVmfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IscT3j2c; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IscT3j2c"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5177d1ff061so4091cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 12:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782330373; cv=none;
        d=google.com; s=arc-20260327;
        b=npIyR2NKX53JnqsN+Y62U1z+Wmb1JJHFkQu8i0INdDRyWkFn9xmsuocBCAZkzfwmAL
         dn83Czsx6TF1TMxn3gNGWeuFfwMK2x9ZwmpHWXJ1RBiIHHvgZx2rcnwz0QLqHOco8KEy
         AlRIjIDkH6MIb6dg+YDy06txf4kbPRq8UhSjz9xUegzxG4Y1boPOijiJ5nelbHLbbZbF
         QT2nLuNXMPgy0KWPz2I1qGudOYFUT7s7ijD26HNuUHVv0JEyfhKjLQhZgEHumFjS58ez
         TAcMBfEWVMDrE0t/y06EaLPQOOLH1pIgdGGKZwVmLByiW2yIONN/md1eY5qG3AR72E9O
         kgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=krArkSfFb7CfSHxpdNg+z3uqM9+trtZmHpOW5jxYIhU=;
        fh=TIG+Y/WUcYuxeLBpo83yQ+EYFs6Q8sB94E7O59GoE/M=;
        b=FSpy2gVGAjjGKZCLyDZYyd4l8pYdVeKmTSrzaQ2LokOY9GUkjhPug/Iss0xpLLnyqi
         rk4ug9NobyovI1/04r3MgIQaCCh5kRoEZUk0xLnctMEt14PeSVAq4ctGkHFr3Twzn0WH
         TR47uag/nxkZCOYOumgVpt5074GBnm+WEScZP62CLC1z1csRkU1KEzFdawi/5yfYo5BC
         H/iER/mTspCAmhlyA/zLNd9wHBhfoeGUziBNIlS/jEQjBUIN1fHvxxxs+YgEd+9iI/LR
         9RPfQ/HiBYlAqATu7QA0LISRZVQb+wKFOwnhAWq2EFtQfEPaY9/vJiS5nkOWlxq5pWjL
         KjvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782330373; x=1782935173; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=krArkSfFb7CfSHxpdNg+z3uqM9+trtZmHpOW5jxYIhU=;
        b=IscT3j2cM+myktl26U5yv+eKjwNXQDQcTd1W3XfaqKSLJxlMcmjSKiwm+Y6TzIIUzB
         n/fgBa6b9KDHgUMMESeHgpszBRKneOi35Y3zH9z4Vx5qYZmAQKxdy4zqzLysohW0Duq/
         tmnkU0kIdzWsP+I6jOQcURt0E72CRZ7Wa0x6y6G2qz19AVg3FZ9p/+sMD0wAZ4GE4enB
         zuCRTzfBwEU1fdqeauFemuQvWp8bbgwR1GwGfAJ0h+etAB06MpdJmBjAg8UXE/Kjxali
         zV6hliJBmAPDlM/JDPQ6aArgY68OKle1A3jECWNb70ORNKP6rxITqr6RCaYCznDRDZfD
         J5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782330373; x=1782935173;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=krArkSfFb7CfSHxpdNg+z3uqM9+trtZmHpOW5jxYIhU=;
        b=j91mgkiPOJM2RcArAU+bFLYmb836zmhTKWitvu5OoW7nj3+yWe2bSnePe/yikGBkMn
         QXXGeWkOrZ11vW9y/WIRy1xc4W7OiKa4XdFh+ZTc3zaOYlF6JDyi5+7gomGAbqaBZl10
         iPmHAMVRRBCqoKR0A3ouxqfQwB3NsamnsnDua6ZzHVcxRF3M7PwBwaXOhBTAWdQjFnQY
         xtLSBuxtG12TNqZisF58po14Lf1M6lggPNVDiJXL+0ocGKIlbWVBCllq+BF2j1JT/OHa
         oqy6N1a3K28EqLp8SXwb+VYlaETuL8RCTcj01+aENr6CD0N36fxhOGKmBePKtN0YGOEs
         NrEA==
X-Forwarded-Encrypted: i=1; AFNElJ8xNTSKAMVVmCLLiVikFwb0j+e3gaNpi+vdvcLXY8+HFGSomSfBzkUwd1JH8D2629R5lVxxg/RxQyx6cVAySOoQ+U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJem6F5mdxtaDB+MYoakXZ6qV71GefGVLNz1Cyoc8utSv20e7
	tjYIoPlnrWeuADzr0LIXJHvgpHQcU/CCVISqrP6m35BQtiEURgQpJv8n3rEmRDwNr7/cjL96TF5
	f2IESG6vade+Q6ItviHat8lDzjH6cy78BWTPA2A/u
X-Gm-Gg: AfdE7ckLFB6633jFsk5HW9VAiDD1+SOcggDUwIHgcLdl/+J7HXVtHNanHcmH+Iv6WEU
	tPOLlkRDa+kbkxHqDpBGijE+zxD1gXO1X3V04ipnO7aUFpZkUbrAUqnzjRtYdTOuvPDnoRIcBty
	YtLZiTiHfrkRLTmHHnpV1Oxe3Yi83UfIjCiFWEj1Mux+rhHR+aE/lY5pIMF5SliCrcPkFwhVFU8
	/vldDunWAopzwKedzxAhKbRMqpfiycqbvlD/2Y2zifmb9BI2loq3DY+uNlWwmjse0cmqE8zxg==
X-Received: by 2002:a05:622a:2610:b0:517:5ec3:b59c with SMTP id
 d75a77b69052e-51a6e99fc93mr1937981cf.2.1782330372007; Wed, 24 Jun 2026
 12:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-31-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-31-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 24 Jun 2026 20:45:00 +0100
X-Gm-Features: AVVi8Cez-yY3_OVx_h8BxVH0ATv4uny51wKb-OuaGNiYJDfP7lcenX8snv1e4WE
Message-ID: <CA+EHjTw-KkcCjyzvf_oaD3=XAQsA8mD++KhM3k8mvEzWAFD1pA@mail.gmail.com>
Subject: Re: [PATCH v8 31/46] KVM: selftests: Test basic single-page
 conversion flow
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

On Fri, 19 Jun 2026 at 01:32, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Add a selftest for the guest_memfd memory attribute conversion ioctls.
> The test starts the guest_memfd as all-private (the default state), and
> verifies the basic flow of converting a single page to shared and then back
> to private.
>
> Add infrastructure that supports extensions to other conversion flow
> tests. This infrastructure will be used in upcoming patches for other
> conversion tests.
>
> Add test as an x86-specific test since guest_memfd's testing
> vehicle (KVM_X86_SW_PROTECTED_VM) is x86-specific.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/Makefile.kvm           |   1 +
>  .../kvm/x86/guest_memfd_conversions_test.c         | 199 +++++++++++++++++++++
>  2 files changed, 200 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 4ace12606e937..b0e64a6dde21a 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -152,6 +152,7 @@ TEST_GEN_PROGS_x86 += x86/max_vcpuid_cap_test
>  TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
>  TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
>  TEST_GEN_PROGS_x86 += x86/aperfmperf_test
> +TEST_GEN_PROGS_x86 += x86/guest_memfd_conversions_test
>  TEST_GEN_PROGS_x86 += access_tracking_perf_test
>  TEST_GEN_PROGS_x86 += coalesced_io_test
>  TEST_GEN_PROGS_x86 += dirty_log_perf_test
> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> new file mode 100644
> index 0000000000000..8e09e241723e5
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Google LLC.
> + */
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +#include <linux/align.h>
> +#include <linux/kvm.h>
> +#include <linux/sizes.h>
> +
> +#include "kvm_util.h"
> +#include "kselftest_harness.h"
> +#include "test_util.h"
> +#include "ucall_common.h"
> +
> +FIXTURE(gmem_conversions) {
> +       struct kvm_vcpu *vcpu;
> +       int gmem_fd;
> +       /* HVA of the first byte of the memory mmap()-ed from gmem_fd. */
> +       char *mem;
> +};
> +
> +typedef FIXTURE_DATA(gmem_conversions) test_data_t;
> +
> +FIXTURE_SETUP(gmem_conversions) { }
> +
> +static size_t page_size;
> +
> +static void guest_do_rmw(void);
> +#define GUEST_MEMFD_SHARING_TEST_GVA 0x90000000ULL
> +
> +/*
> + * Defer setup until the individual test is invoked so that tests can specify
> + * the number of pages and flags for the guest_memfd instance.
> + */
> +static void gmem_conversions_do_setup(test_data_t *t, int nr_pages,
> +                                     int gmem_flags)
> +{
> +       const struct vm_shape shape = {
> +               .mode = VM_MODE_DEFAULT,
> +               .type = KVM_X86_SW_PROTECTED_VM,
> +       };
> +       /*
> +        * Use high GPA above APIC_DEFAULT_PHYS_BASE to avoid clashing with
> +        * APIC_DEFAULT_PHYS_BASE.
> +        */
> +       const gpa_t gpa = SZ_4G;
> +       const u32 slot = 1;
> +       struct kvm_vm *vm;
> +
> +       vm = __vm_create_shape_with_one_vcpu(shape, &t->vcpu, nr_pages, guest_do_rmw);
> +
> +       vm_mem_add(vm, VM_MEM_SRC_SHMEM, gpa, slot, nr_pages,
> +                  KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
> +
> +       t->gmem_fd = kvm_slot_to_fd(vm, slot);
> +       t->mem = addr_gpa2hva(vm, gpa);
> +       virt_map(vm, GUEST_MEMFD_SHARING_TEST_GVA, gpa, nr_pages);
> +}
> +
> +static void gmem_conversions_do_teardown(test_data_t *t)
> +{
> +       /* No need to close gmem_fd, it's owned by the VM structure. */
> +       kvm_vm_free(t->vcpu->vm);
> +}
> +
> +FIXTURE_TEARDOWN(gmem_conversions)
> +{
> +       gmem_conversions_do_teardown(self);
> +}
> +
> +/*
> + * In these test definition macros, __nr_pages and nr_pages is used to set up
> + * the total number of pages in the guest_memfd under test. This will be
> + * available in the test definitions as nr_pages.
> + */
> +
> +#define __GMEM_CONVERSION_TEST(test, __nr_pages, flags)                                \
> +static void __gmem_conversions_##test(test_data_t *t, int nr_pages);           \
> +                                                                               \
> +TEST_F(gmem_conversions, test)                                                 \
> +{                                                                              \
> +       gmem_conversions_do_setup(self, __nr_pages, flags);                     \
> +       __gmem_conversions_##test(self, __nr_pages);                            \
> +}                                                                              \
> +static void __gmem_conversions_##test(test_data_t *t, int nr_pages)            \
> +
> +#define GMEM_CONVERSION_TEST(test, __nr_pages, flags)                          \
> +       __GMEM_CONVERSION_TEST(test, __nr_pages, (flags) | GUEST_MEMFD_FLAG_MMAP)
> +
> +#define __GMEM_CONVERSION_TEST_INIT_PRIVATE(test, __nr_pages)                  \
> +       GMEM_CONVERSION_TEST(test, __nr_pages, 0)
> +
> +#define GMEM_CONVERSION_TEST_INIT_PRIVATE(test)                                        \
> +       __GMEM_CONVERSION_TEST_INIT_PRIVATE(test, 1)
> +
> +struct guest_check_data {
> +       void *mem;
> +       char expected_val;
> +       char write_val;
> +};
> +static struct guest_check_data guest_data;
> +
> +static void guest_do_rmw(void)
> +{
> +       for (;;) {
> +               char *mem = READ_ONCE(guest_data.mem);
> +
> +               GUEST_ASSERT_EQ(READ_ONCE(*mem), READ_ONCE(guest_data.expected_val));
> +               WRITE_ONCE(*mem, READ_ONCE(guest_data.write_val));
> +
> +               GUEST_SYNC(0);
> +       }
> +}
> +
> +static void run_guest_do_rmw(struct kvm_vcpu *vcpu, u64 pgoff,
> +                            char expected_val, char write_val)
> +{
> +       struct ucall uc;
> +       int r;
> +
> +       guest_data.mem = (void *)GUEST_MEMFD_SHARING_TEST_GVA + pgoff * page_size;
> +       guest_data.expected_val = expected_val;
> +       guest_data.write_val = write_val;
> +       sync_global_to_guest(vcpu->vm, guest_data);
> +
> +       do {
> +               r = __vcpu_run(vcpu);
> +       } while (r == -1 && errno == EINTR);
> +
> +       TEST_ASSERT_EQ(r, 0);
> +
> +       switch (get_ucall(vcpu, &uc)) {
> +       case UCALL_ABORT:
> +               REPORT_GUEST_ASSERT(uc);
> +       case UCALL_SYNC:
> +               break;
> +       default:
> +               TEST_FAIL("Unexpected ucall %lu", uc.cmd);
> +       }
> +}
> +
> +static void host_do_rmw(char *mem, u64 pgoff, char expected_val,
> +                       char write_val)
> +{
> +       TEST_ASSERT_EQ(READ_ONCE(mem[pgoff * page_size]), expected_val);
> +       WRITE_ONCE(mem[pgoff * page_size], write_val);
> +}
> +
> +static void test_private(test_data_t *t, u64 pgoff, char starting_val,
> +                        char write_val)
> +{
> +       TEST_EXPECT_SIGBUS(WRITE_ONCE(t->mem[pgoff * page_size], write_val));
> +       run_guest_do_rmw(t->vcpu, pgoff, starting_val, write_val);
> +       TEST_EXPECT_SIGBUS(READ_ONCE(t->mem[pgoff * page_size]));
> +}
> +
> +static void test_convert_to_private(test_data_t *t, u64 pgoff,
> +                                   char starting_val, char write_val)
> +{
> +       gmem_set_private(t->gmem_fd, pgoff * page_size, page_size);
> +       test_private(t, pgoff, starting_val, write_val);
> +}
> +
> +static void test_shared(test_data_t *t, u64 pgoff, char starting_val,
> +                       char host_write_val, char write_val)
> +{
> +       host_do_rmw(t->mem, pgoff, starting_val, host_write_val);
> +       run_guest_do_rmw(t->vcpu, pgoff, host_write_val, write_val);
> +       TEST_ASSERT_EQ(READ_ONCE(t->mem[pgoff * page_size]), write_val);
> +}
> +
> +static void test_convert_to_shared(test_data_t *t, u64 pgoff,
> +                                  char starting_val, char host_write_val,
> +                                  char write_val)
> +{
> +       gmem_set_shared(t->gmem_fd, pgoff * page_size, page_size);
> +       test_shared(t, pgoff, starting_val, host_write_val, write_val);
> +}
> +
> +GMEM_CONVERSION_TEST_INIT_PRIVATE(init_private)
> +{
> +       test_private(t, 0, 0, 'A');
> +       test_convert_to_shared(t, 0, 'A', 'B', 'C');
> +       test_convert_to_private(t, 0, 'C', 'E');
> +}
> +
> +
> +int main(int argc, char *argv[])
> +{
> +       TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
> +       TEST_REQUIRE(kvm_check_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES) &
> +                    KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +
> +       page_size = getpagesize();
> +
> +       return test_harness_run(argc, argv);
> +}
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
