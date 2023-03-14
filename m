Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED535C6FD1D
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 14 Mar 2023 10:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCNKXs (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 14 Mar 2023 06:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCNKX2 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:23:28 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D89120048
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:22:56 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id h34so10202466uag.4
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678789375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oK6l1bLYaFxR9jVa3Sb0b7gfGtMaLgpY33m0htG6rbI=;
        b=qAujV86UmC0NGw1Dtp+ks5Kkvw0sAmpu4k5RJs+CgI9NiKjNTCQm85QaTy7hj8l8li
         Xz2eBYt5pG0VMBC4C1pWsslZpUACSnplxf6DzTBH3z5YRtB5vbtmx+ddOF6T1ALCs9Z7
         SUcMt3t6fAUaLUr0E87yIFc5SH0xPZMf4qMYRlzmhPQI3qFIrOxFZUJaczbf7HInkDdC
         B+obj5Wq6p90KHwSEZBTWvlkXbXHmbhigX3n+Nps2zYBBx5yfyRUrtMR3w4YRHOtKk+f
         gg/jeGowVu4OP175v4gCgoqp8Vw2g3VU9LJaHuxt7unhbBxndDnJZUvT+MXGRn69h1XC
         sVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678789375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oK6l1bLYaFxR9jVa3Sb0b7gfGtMaLgpY33m0htG6rbI=;
        b=JzPqLanum+Dk4xsVBK2fE54a1btjJGnCkUe8NMy3ZUAeR+/YJCa+iAJVY00lDoqn2m
         G3fA5OQqfWO48qGx1LFFHM8jJRs+/unwvuVIT4o7tYM9c6tHHjZaqvt7MrN1YqQVYvC7
         4rLWLTcgg5PALAAYJdJhL2cW57d3ZTbgxkXoblC6HpEsE6kExeB7QTttwAxE+Et2mND7
         cTgaoEjfDksVKqV+1oXmiP2EIPrQ5BZHFcsPFnSZ78m4jqZhvoxURb2Ueh5GZ47QS+oR
         pf1TrMZEZ8Y2db1aaPp7KVPOQUtCpX+1YDtMRtmkcaRnoPe1bH2YJ1z+PCZ8pUt897Bz
         wXnQ==
X-Gm-Message-State: AO0yUKWz46BU8JX/facBFJzgCF6k9BdVBhvs20SpSmsfjflsUMuetWgl
        6UswuGRQ+ET9r4iBMFPpQ5j3NAU3lpS57nkSpmIurCAB3LnZoTgaPBigyw==
X-Google-Smtp-Source: AK7set8hMUVOa/qYE8BdEgeaQtRuTH3svAjQltS166F8lAkGHwHJevtx5wqU7pymCMpPOF1NLi8bpKbTkfXr41b8ZMY=
X-Received: by 2002:ab0:5402:0:b0:688:d612:2024 with SMTP id
 n2-20020ab05402000000b00688d6122024mr23748723uaa.2.1678789375323; Tue, 14 Mar
 2023 03:22:55 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 14 Mar 2023 15:52:44 +0530
Message-ID: <CA+G9fYtF-XEKi9YNGgR=Kf==7iRb2FrmEC7qtwAeQbfyah-UhA@mail.gmail.com>
Subject: selftests: ftrace: event filter function - test event filtering on
 functions [FAIL]
To:     open list <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Results from Linaro=E2=80=99s test farm.

selftests ftrace failed on qemu-x86_64 and qemu-arm64.
Please find the test log below.

Is this expected to fail ? Am I missing anything ?

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

kselftest: Running tests in ftrace
TAP version 13
1..1
# selftests: ftrace: ftracetest
# =3D=3D=3D Ftrace unit tests =3D=3D=3D
# [1] Basic trace file check [PASS]

...

# [23] event filter function - test event filtering on functions [FAIL]

...
# [58] Kretprobe %return suffix test [PASS]
# [59] Register/unregister many kprobe events
[  431.662904] trace_kprobe: Could not probe notrace function startup_64
[  431.669846] trace_kprobe: Could not probe notrace function _stext
[  431.674104] trace_kprobe: Could not probe notrace function _text
[  431.675908] trace_kprobe: Could not probe notrace function
secondary_startup_64
[  431.677876] trace_kprobe: Could not probe notrace function
secondary_startup_64_no_verify
[  431.679899] trace_kprobe: Could not probe notrace function __pfx_verify_=
cpu
[  431.681738] trace_kprobe: Could not probe notrace function verify_cpu
[  431.683667] trace_kprobe: Could not probe notrace function
__pfx_sev_verify_cbit
[  431.685594] trace_kprobe: Could not probe notrace function sev_verify_cb=
it
[  431.687381] trace_kprobe: Could not probe notrace function start_cpu0
[  431.689225] trace_kprobe: Could not probe notrace function __pfx___start=
up_64
[  431.691223] trace_kprobe: Could not probe notrace function __startup_64
[  431.693088] trace_kprobe: Could not probe notrace function
__pfx_startup_64_setup_env
[  431.695021] trace_kprobe: Could not probe notrace function
startup_64_setup_env
[  431.697012] trace_kprobe: Could not probe notrace function
__pfx___traceiter_initcall_level
[  431.700780] trace_kprobe: Could not probe notrace function
__pfx___traceiter_initcall_start
...
[  439.183587] trace_kprobe: Could not probe notrace function
__pfx_hv_check_msr_access
[  439.186192] trace_kprobe: Could not probe notrace function
__pfx_kvm_hv_flush_tlb
...

# [106] (instance)  event filter function - test event filtering on
functions [FAIL]

...
#
# # of passed:  109
# # of failed:  2
# # of unresolved:  3
# # of untested:  0
# # of unsupported:  3
# # of xfailed:  1
# # of undefined(test bug):  0
not ok 1 selftests: ftrace: ftracetest # exit=3D1

log link,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230314/te=
strun/15564370/suite/kselftest-ftrace/test/ftrace_ftracetest/log

--
Linaro LKFT
https://lkft.linaro.org
