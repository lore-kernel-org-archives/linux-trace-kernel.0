Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3453C13EE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371072; cv=pass; b=J7J6DUlLum/mzHy6bO9u7J8vislr0aoNNzD57MlTpZbhZK/LXdp4jJCPcTO1h1Hrl+XpgiGqxD1pElheNcarBZZwg1HpSMYcvwa0VMwUfYLAdQih9V652k8JWqLxWrmvvZ9Egla8zCjOPg0f+yZXa6+ExSbVug0iI1QvDhfHEJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371072; c=relaxed/simple;
	bh=zdplWEMU4ZutyOkbI+3SiQhFO5MjqtwHboLbHuF46t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYXbrYzok4WeQxanCDOvqO/lukVwd2pVKtpZfZoyJXmzEj7RZU9oO77JHQwkvAzq/o//VTnTwqh3tLDlueccxALRjOU3TLCFiSKnRJOA5/U103Fj9ONV94Tx3Oue2r1vne68iW0iQ0F1+XE39te/hynv4UqjrFsjGZYXZUvAB1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9sZA9BW; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9sZA9BW"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51765331535so124511cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 00:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782371068; cv=none;
        d=google.com; s=arc-20260327;
        b=BIdwQ60q79TBH3O401c8hVJFiBQbWAmvdnMuxlQLySuDHPzwZ7NB7w94efj94Ut9vg
         /juElHxuY/6MDBimj2B6iVosqSFJkRGNJMCv1Vsl9A8aDODP7IjgqRkcXekNC29KRn4H
         q8TrwgLGuzCkK+Rxsk8S6mn1+D2AI4YI7efVvxP/zDmc0gRTR+uepzXAisIU0IcILZPw
         5sL8AAd7eyEUXJ8ISVaHj2RfLALCi6u9Ud7gYXCdOrQ2egO9jLJRBPiH0eRx4OfQwQpu
         eCgi99csNoNk0aZk1GeXEaAHTAfse9ifwX0wHdLSfC85B3McTWDEo6fvHvqv213K6lxU
         zevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EviLczuyy1yyIrBaIYV/LFmo2BGtZCvU6IS38nnd4b4=;
        fh=3jiQ4bdx4Vot+06wQCyg8262PHG/yu1MGaoj7+zTGX4=;
        b=iH3BEjjow5vvYQiuT6Q2M4mqkXo6TN314TMP/tLDUXCEb9fo7phiJX3SQ1RZ2r3QkQ
         pxHJhdh5lYCpe1dtR4FaqE4PorSHd6UAQdROysBDH6OKeCqYd5/Dk1dyUyd0g7gual4B
         sH/wVGYBuO2Y4wCInZXJf5iAjCj/86i5wQb9y7rONAXhKTgSWIKR9rejwHXQXIKhCoQk
         EIfj2S/oN9TV8EJTJfy7Pku6ssQriJk522T8lI6DVicLyjSq3kKKgsEsKxTwK1+FjsKt
         SHk2zPq9bTbxiImK2P95x8k31NQREbL/QD6LiFP446248HYc9dwrT+F8DYd0FPGSvzo9
         PXOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782371068; x=1782975868; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EviLczuyy1yyIrBaIYV/LFmo2BGtZCvU6IS38nnd4b4=;
        b=q9sZA9BWKj8e5gAjlUeJer2U2/ygGOKPecKmhNST+2LJBoxivs8AJXXFykgll7PRWs
         yihfiGuo62y6GSheBuKyR/+LUCGaz6m1TKOXQCbY7gr032+Sv8cyOeCwJ3fHtNNnrlvk
         ghglZnhiy5IOkjZmJz7E8N7AcVq2ZwXQ4BY+siJlDAICY3Lmasm7aJrzNAaCXL0jzQr+
         e0Ql3yaWSYiqPAEA2wJiHk4u8un7IrseLEVKwdisFxMHQDYRTFZ6MgW9yhltmVdKimE4
         Ja4a9271KjF0etmXnh1g2SlwlCVDG4CWteGt2IpuwKNiJL6z+ALUcRaAbLlQrVlCAYVq
         Z4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782371068; x=1782975868;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EviLczuyy1yyIrBaIYV/LFmo2BGtZCvU6IS38nnd4b4=;
        b=Pcdrk7YWgILEDd+jH0WZ55Er52VR2ul5LmXw/ehW0VldzsczLC1BcMTO/bTsfpnVaC
         XVNYp4ST7i7MymW5xAgABy+ZpPSY+UA1Kas7bMK3jWBTzS8rBswGSBCcjCBCTiJ0/DcK
         oxyAJLI+p9l52lDV1zNJYgYVnB9l6ksc7ja7bYB+B+HOlFcVVmaClBaWIW6mEH1ziT89
         J/ayhCzklpQ7ovm6f0ZCiAQTqOgZfFJqryjpb7e90nCZR0W5RNghQtFTqCjgmiXACNqV
         +OhxiNzP8okhfPqdtViVkcIhLd5fpLn/MKGRAVll4ScJc1PkxRaz1uefguuXV7cMHOSt
         et6g==
X-Forwarded-Encrypted: i=1; AFNElJ+xxEJ2agmwdSOLDRr8wEPnD7/On4GNdpRIj5ARh2ZmzHqvuj0pgGZrc8VqLThyjyjsdFA3BA7i7HT2NtmscYtzlQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoRMGM6zLViTBnukiTnVrt0aZrBWlPFkNKtKr+46N7o6EUmy5n
	bxUv35nhCcYG03Vrw4yrutBxCfPk5E8rkPNOwpnzgOTOXggsOZdx3SIOTkBfle6arR6S0AR8/2W
	5H9srnPW7yjRM+JStXYtxjHBIWuJmEMJqIif5ssc4
X-Gm-Gg: AfdE7cnvq7JYgIaZMZWdqaM6R+fbXiHxXsUNVsjuS52mTIB6OnBTzejJExpW0RQfu0p
	UNjgpIbKNF8IYchqGqyg7QNh/PimTJ0lbStTAm8hUdnU8VZ28BvOjFpVWB/iMbZa1PeKoxHrjDz
	pCBRmQSRZwcR7ero+p1d+lu413IoXZHr8ctw110Uar42gJlDxk9eDzkf/QfYeGUThKnuWs5F9iE
	2fpeWM6VZS/ojl+vPvSVIuscbMPPZNs2DEXxIw1yJAR82sdn4M+PMyOtCROoTE/7cT3UfrYyw==
X-Received: by 2002:ac8:5a88:0:b0:519:b655:235 with SMTP id
 d75a77b69052e-51a703faaaamr4395391cf.3.1782371067208; Thu, 25 Jun 2026
 00:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-36-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-36-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 08:03:50 +0100
X-Gm-Features: AVVi8CfPiivQ2jTF4C4b2T4SW03MiAlvIrJh5OdhMlg3bv2FAUX7zsWQXsWcZEs
Message-ID: <CA+EHjTzFUayXCh2SBe7Nwu7YEO3aUmL1Fo1hE_v8OvUw7MWO6w@mail.gmail.com>
Subject: Re: [PATCH v8 36/46] KVM: selftests: Test that truncation does not
 change shared/private status
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
> Add a test to verify that deallocating a page in a guest memfd region via
> fallocate() with FALLOC_FL_PUNCH_HOLE does not alter the shared or private
> status of the corresponding memory range.
>
> When a page backing a guest memfd mapping is deallocated, e.g., by punching
> a hole or truncating the file, and then subsequently faulted back in, the
> new page must inherit the correct shared/private status tracked by
> guest_memfd.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  .../selftests/kvm/x86/guest_memfd_conversions_test.c       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index 0b024fb7227f0..f03af2c46426f 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> @@ -10,6 +10,7 @@
>  #include <linux/sizes.h>
>
>  #include "kvm_util.h"
> +#include "kvm_syscalls.h"
>  #include "kselftest_harness.h"
>  #include "test_util.h"
>  #include "ucall_common.h"
> @@ -309,6 +310,19 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(unallocated_folios, 8)
>                 test_convert_to_shared(t, i, 'B', 'C', 'D');
>  }
>
> +/* Truncation should not affect shared/private status. */
> +GMEM_CONVERSION_TEST_INIT_SHARED(truncate)
> +{
> +       host_do_rmw(t->mem, 0, 0, 'A');
> +       kvm_fallocate(t->gmem_fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page_size);
> +       host_do_rmw(t->mem, 0, 0, 'A');
> +
> +       test_convert_to_private(t, 0, 'A', 'B');
> +
> +       kvm_fallocate(t->gmem_fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page_size);
> +       test_private(t, 0, 0, 'A');
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
