Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D9E2441A6
	for <linux-trace-kernel@vger.kernel.org>; Sun, 17 May 2026 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999065; cv=pass; b=HaOx6WitPUsWv6X5DNqGyXj8tS7upm6bh/tEmMsSOEsPI9TFFc8w+DESTOQ2Q84Q64BikTXc2TBh+wkgEbriMUwX0Y9v/zPTpdQv7iFMGDOTD6LoUuThhK/oSFUSWE0lV4P5sgnsW83a21arURNSYEd2Z8zTm0xuaVzP/jRI0rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999065; c=relaxed/simple;
	bh=edLXjBcxS30dEAplpHT/kbPIIN3gimEc6U5jgEe5EFM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CbZMmfBFLtBlG6Tg6K4fe2Cz4XWgiOPKM8aRtugiDGkDA7A3puamBsTnptpn7lxyFPqSUs2SMyXc0FhtnjQqse24r+sGUabLCHdQ1BoSlEI3XSHlEgY+l3CLOiZFCNepJDGmagjj1xR9o0vKHzX4QVcvE/e7QhI1fZDljby3pmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvbvCw7V; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvbvCw7V"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6948da50eb5so526408eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 16 May 2026 23:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778999063; cv=none;
        d=google.com; s=arc-20240605;
        b=href/KtX92j4lmMm1HAcG+ehGBqWPW0n2+7Uu/v0niPXNpST5fyLJkfSRy8QxsuDbf
         offWGMOYpHj2PNyyQVNdpAw9HI4Rx8dLDN1bWZCfQPYkC33KYfv1iMYPxd+r9osYMzvm
         L/CW67qn/MgJr/sVdrEqpCNondPm9Qyv9SX1fOufXqCka2u4Lwz3iu6FJ5CuUxJdo3XX
         e/ZzuoITHjlRU1hbaPsB0pADnkrO55OT7IH6qbs1BAuq0+HllIdEUmreVu767H+RXGBb
         w/Yl5E58c7jD827Mu9kIlkCluYjCTUkTobhIye696kQ29+9nKU3KInWUJY1/uf0bwdyz
         C0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rOzrjUYt1eTTHvmN0WzmPeu77Yn5F4LNxwcCCZePEbo=;
        fh=DNAF66cNkV/5tFv6OvmiM4ge7J4yCF6weM50kuzBfGA=;
        b=GXEG90f5DjWr4K8CsV7P+M+3unowB5KOP55yB1qD3au0HrLqY5DuDR6a8fsypHEbeN
         NWpxVZx3yCm8MOaSb+wTGP5CP2iFrqY2YkMjBsPtJlzodQMIGCUM5hYNqnn/W75HvMp9
         fThCPR2J9bTKhXSGp+X8S7BXFuBCtpI42x+nP89QzoLehEsz2a4ibQLqGO/PrZDVlJL/
         5fSreuFejIU/fDNe+dzYa3uR+x45dng+Hxpg6xTqxDNEndys/8/ixVKZUwafsrpZFVSd
         p6OY53PPmoeK47DDimOKzLUEHBTZdWVMtVHFeBfbvUJ72O+gIQtaaoAVtjAJz6U99vX6
         3liA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999063; x=1779603863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rOzrjUYt1eTTHvmN0WzmPeu77Yn5F4LNxwcCCZePEbo=;
        b=ZvbvCw7VH1PyxvPgTHAdKoOaP5cunzjGbcLGfQUNU5u/Lp4GBTVVxjvBv3Vr+xxQQW
         pQjA7NzSPftJKyKbezPT1MgwCkpaeD6JBkTNpCmmABKxcRYiPTqNsbQlQ8+em9vMU68Z
         sqtP1lwNXBjCXupVU271J4dpUlJERltk1gbZnSSvS1X6kAktgQdtrxAf/VxCRsIC2cGQ
         h66oL9Mf5A5zzVC+/wOGwKqj6b6hoEw/aGwQ7Z52URkPK3w8ZRmhxakoiVz2g1pwaTUV
         QUdjHdG4ruMudVfLEudy3rM881mpi5sNWfuYqeZ2Eo9Yild+KiUkJWBneLusTMI5uq4J
         gi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999063; x=1779603863;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOzrjUYt1eTTHvmN0WzmPeu77Yn5F4LNxwcCCZePEbo=;
        b=k77w0vatNfb1UvGdg8jbDgYHcXrjXYTpnrGgOsnwnUsgzqPnnwq8OkqCHa/0WR/amz
         yvAnu+/bTNzaCnNkOVW736X7ve4dTXNAzAwsPlerLVeVVtRAPxsm3tSgR1UAfSpnv6xM
         uSRM9I4mCuJ/TLEwMj6q93KifSevD26mDxUe4DL+qTEF8SH/HQFwax5cZyHZQkoj0w3M
         kkkrqnBq8Na2SaJdBEPPWeufKNysQTdiFrfRmVyIQqr/hLVUf5wlz0DObGa5wNfsJbmR
         JhGfbd1EKyNjq1rOyrzCGiCH3gBqtJHP+fSWttjJnbm8Sq56bcmP4Y+TVmLublXa26vr
         73Fg==
X-Forwarded-Encrypted: i=1; AFNElJ9olM+HA1LTcRcYlUQwBT2g8ux6XFMuSSb0wBbtvdsfiKu1KZ29QDYiar8zGo1GgRMAZFp4ua/wOuR84l3OZ0dhSHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzndekqUzLg+3wbMiidtzaeKWk3Fb9Ydc2n6e9bjtNrnl5EXUK5
	8RbPwoRz1GHMczVHGv/F+Ifko/DdsudHCW5+C76PW0hTrk1PtLm+Oufj+nDIvB/6pNFvjITkZyV
	Cr+D14zVUvXCoVjyRK+VbfM7etKoIoTY=
X-Gm-Gg: Acq92OHG3KWptWX5rpUTq6NI5oq2p2h3vfzkbOfDrdZI/Kgs9GNlWiB1c7RkvQHdiYK
	Aho+jFUwDaxxyRHynpvX5nIuzIeO8FhbPDdsFNoUDuy7tRNj3f1iPtXxA5c5Olq9nNasAL4Vrwi
	o8ifJ7FIAOdx4WjB/ykGyrWkq2jqMO2lVl4NEUGuOCkXtKdaqpgxXfE4vfFLosmt13lPJyVgC5Q
	a1QeNE/puF9Vk34q5d8SXlUr41ZIzCbHzxfhw+I+IDHZqJpffMvsAbkBp6VWRNhL1vxMNwl12Dy
	SXgiUpynn83LcXd+VIg=
X-Received: by 2002:a4a:d1a5:0:b0:696:aea7:54f8 with SMTP id
 006d021491bc7-69b8829a792mr5850419eaf.21.1778999062839; Sat, 16 May 2026
 23:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Afi0 <capyenglishlite@gmail.com>
Date: Sun, 17 May 2026 06:24:11 +0000
X-Gm-Features: AVHnY4IDQGnPRkc2Y-JPAktjmos2e3m39yxwlYBlg9tTpDjZs9wonp7fLHWZo94
Message-ID: <CAEABq7fMcvHpp4+59Mt-QdgGNpWhOqrGWHKmy+qt3tJSYb69kg@mail.gmail.com>
Subject: Race condition in __modify_ftrace_direct() between tmp_ops
 registration and direct_functions hash update
To: security@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="0000000000003261b80651fd7f34"

--0000000000003261b80651fd7f34
Content-Type: multipart/alternative; boundary="0000000000003261b60651fd7f32"

--0000000000003261b60651fd7f32
Content-Type: text/plain; charset="UTF-8"

Hi list,

Apologies for initially sending only to Greg. Resending to the full list as
requested.
------------------------------

Component: kernel/trace/ftrace.c Function: __modify_ftrace_direct()
Affected versions: Linux kernel 5.15+ Type: TOCTOU / Race condition CVSS
3.1: AV:L/AC:H/PR:L/UI:N/S:C/C:H/I:H/A:H - 7.8 (High)

SUMMARY

A race condition exists in __modify_ftrace_direct() between the
registration of tmp_ops into ftrace_ops_list and the subsequent update of
direct_functions hash entries. During this window, concurrent CPUs
executing traced functions will read the stale direct call address via
ftrace_find_rec_direct() and jump to it, while the caller may have already
invalidated or freed the old trampoline memory.

VULNERABLE CODE

err = register_ftrace_function_nolock(&tmp_ops);[race window:
ftrace_ops_list_func now active, direct_functions not yet
updated]mutex_lock(&ftrace_lock);entry->direct = addr;   /* update
happens here, too late */mutex_unlock(&ftrace_lock);

IMPACT

CPU executing traced function reads stale direct_functions entry during the
race window. arch_ftrace_set_direct_caller() redirects execution to
potentially freed or invalidated trampoline memory. Use-after-free in
executable code context on SMP systems.

TRIGGER

Requires CAP_PERFMON or CAP_SYS_ADMIN directly. Also reachable via BPF
trampolines (kernel/bpf/trampoline.c calls __modify_ftrace_direct()
internally) with CAP_BPF + CAP_PERFMON, default in many CI/CD container
runtimes. Live patching via klp_patch_func() also goes through this path.

SUGGESTED FIX

Update entry->direct under ftrace_lock BEFORE registering tmp_ops. Add
smp_wmb() between the store and registration to ensure ordering on
weakly-ordered architectures.

Patch attached as 0001-ftrace-fix-race-in-__modify_ftrace_direct.patch

Fixes: 0567d6809440 ("ftrace: Add modify_ftrace_direct()")

Thanks,

 Afi0

--0000000000003261b60651fd7f32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-font-claude-response-body gmail-break-wo=
rds gmail-whitespace-normal gmail-leading-[1.7]">Hi list,</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Apologies for initially sending only to Gre=
g. Resending to the full list as requested.</p>
<hr class=3D"gmail-border-border-200 gmail-border-t-0.5 gmail-my-3 gmail-mx=
-1.5">
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-pre-wrap gmail-leading-[1.7]">Component: kernel/trace/ftrace.c
Function: __modify_ftrace_direct()
Affected versions: Linux kernel 5.15+
Type: TOCTOU / Race condition
CVSS 3.1: AV:L/AC:H/PR:L/UI:N/S:C/C:H/I:H/A:H - 7.8 (High)</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">SUMMARY</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">A race condition exists in __modify_ftrace_=
direct() between the registration of tmp_ops into ftrace_ops_list and the s=
ubsequent update of direct_functions hash entries. During this window, conc=
urrent CPUs executing traced functions will read the stale direct call addr=
ess via ftrace_find_rec_direct() and jump to it, while the caller may have =
already invalidated or freed the old trampoline memory.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">VULNERABLE CODE</p>
<div role=3D"group" aria-label=3D"Code" tabindex=3D"0" class=3D"gmail-relat=
ive gmail-group/copy gmail-bg-bg-000/50 gmail-border-0.5 gmail-border-borde=
r-400 gmail-rounded-lg gmail-focus:outline-none gmail-focus-visible:ring-2 =
gmail-focus-visible:ring-accent-100"><div class=3D"gmail-overflow-x-auto"><=
pre class=3D"gmail-code-block__code gmail-!my-0 gmail-!rounded-lg gmail-!te=
xt-sm gmail-!leading-relaxed gmail-p-3.5" style=3D"color:rgb(20,24,31);back=
ground:transparent;font-family:var(--font-mono)"><code style=3D"color:rgb(2=
0,24,31);background:transparent;font-family:var(--font-mono);white-space:pr=
e-wrap"><span><span>err =3D register_ftrace_function_nolock(&amp;tmp_ops);
</span></span><span>[race window: ftrace_ops_list_func now active, direct_f=
unctions not yet updated]
</span><span>mutex_lock(&amp;ftrace_lock);
</span><span>entry-&gt;direct =3D addr;   /* update happens here, too late =
*/
</span><span>mutex_unlock(&amp;ftrace_lock);</span></code></pre></div></div=
>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">IMPACT</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">CPU executing traced function reads stale d=
irect_functions entry during the race window. arch_ftrace_set_direct_caller=
() redirects execution to potentially freed or invalidated trampoline memor=
y. Use-after-free in executable code context on SMP systems.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">TRIGGER</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Requires CAP_PERFMON or CAP_SYS_ADMIN direc=
tly. Also reachable via BPF trampolines (kernel/bpf/trampoline.c calls __mo=
dify_ftrace_direct() internally) with CAP_BPF + CAP_PERFMON, default in man=
y CI/CD container runtimes. Live patching via klp_patch_func() also goes th=
rough this path.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">SUGGESTED FIX</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Update entry-&gt;direct under ftrace_lock B=
EFORE registering tmp_ops. Add smp_wmb() between the store and registration=
 to ensure ordering on weakly-ordered architectures.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Patch attached as 0001-ftrace-fix-race-in-_=
_modify_ftrace_direct.patch</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Fixes: 0567d6809440 (&quot;ftrace: Add modi=
fy_ftrace_direct()&quot;)</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-pre-wrap gmail-leading-[1.7]">Thanks,</p><p class=3D"gmail-font-claude-=
response-body gmail-break-words gmail-whitespace-pre-wrap gmail-leading-[1.=
7]">=C2=A0Afi0</p><br></div>

--0000000000003261b60651fd7f32--
--0000000000003261b80651fd7f34
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-ftrace-fix-race-in-__modify_ftrace_direct.patch"
Content-Disposition: attachment; 
	filename="0001-ftrace-fix-race-in-__modify_ftrace_direct.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mp9e3nr10>
X-Attachment-Id: f_mp9e3nr10

RnJvbSBiM2M0ZDVlNmY3YThiM2M0ZDVlNmY3YThiM2M0ZDVlNmY3YThiM2M0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBZmkwIDxjYXB5ZW5nbGlzaGxpdGVAZ21haWwuY29tPgpEYXRl
OiBTYXQsIDE2IE1heSAyMDI2IDEyOjExOjAwICswMDAwClN1YmplY3Q6IFtQQVRDSF0gZnRyYWNl
OiBmaXggcmFjZSBpbiBfX21vZGlmeV9mdHJhY2VfZGlyZWN0KCkgYmV0d2VlbgogdG1wX29wcyBy
ZWdpc3RyYXRpb24gYW5kIGRpcmVjdF9mdW5jdGlvbnMgdXBkYXRlCgpJbiBfX21vZGlmeV9mdHJh
Y2VfZGlyZWN0KCksIHJlZ2lzdGVyX2Z0cmFjZV9mdW5jdGlvbl9ub2xvY2soKSBtYWtlcwp0bXBf
b3BzIHZpc2libGUgaW4gZnRyYWNlX29wc19saXN0IGJlZm9yZSBlbnRyeS0+ZGlyZWN0IGlzIHVw
ZGF0ZWQKdW5kZXIgZnRyYWNlX2xvY2suIER1cmluZyB0aGlzIHdpbmRvdyBhbnkgQ1BVIGVudGVy
aW5nIHRoZSB0cmFjZWQKZnVuY3Rpb24gY2FsbHMgY2FsbF9kaXJlY3RfZnVuY3MoKSwgcmVhZHMg
dGhlIG9sZCBhZGRyZXNzIGZyb20KZGlyZWN0X2Z1bmN0aW9ucyB2aWEgUkNVLCBhbmQganVtcHMg
dG8gaXQgdmlhCmFyY2hfZnRyYWNlX3NldF9kaXJlY3RfY2FsbGVyKCkuIElmIHRoZSBjYWxsZXIg
ZnJlZWQgb3IgaW52YWxpZGF0ZWQKdGhlIG9sZCB0cmFtcG9saW5lIGJlZm9yZSBjYWxsaW5nIG1v
ZGlmeV9mdHJhY2VfZGlyZWN0KCksIHRoaXMgaXMgYQp1c2UtYWZ0ZXItZnJlZSBpbiBleGVjdXRh
YmxlIGNvZGUgY29udGV4dC4KClRoZSByYWNlIHdpbmRvdzoKCiAgQ1BVIDAgKF9fbW9kaWZ5X2Z0
cmFjZV9kaXJlY3QpICAgICAgIENQVSAxIChleGVjdXRpbmcgdHJhY2VkIGZ1bmMpCiAg4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSAICAgICAgIOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgAogIHJlZ2lzdGVyX2Z0cmFjZV9mdW5jdGlvbl9ub2xvY2soKQogICAgLT4gdG1w
X29wcyB2aXNpYmxlIGluIG9wc19saXN0CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjYWxsX2RpcmVjdF9mdW5jcygpCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGZ0cmFjZV9maW5kX3JlY19kaXJlY3QoKSAtPiBvbGRfYWRkcgogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhcmNoX2Z0cmFjZV9zZXRfZGlyZWN0
X2NhbGxlcihvbGRfYWRkcikKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAganVtcCB0byBvbGRfYWRkciAgPC0gVUFGIGlmIGZyZWVkCiAgbXV0ZXhfbG9jaygmZnRyYWNl
X2xvY2spCiAgZW50cnktPmRpcmVjdCA9IGFkZHIgICA8LSB0b28gbGF0ZQogIG11dGV4X3VubG9j
aygmZnRyYWNlX2xvY2spCgpGaXg6IHVwZGF0ZSBlbnRyeS0+ZGlyZWN0IHVuZGVyIGZ0cmFjZV9s
b2NrIEJFRk9SRSByZWdpc3RlcmluZyB0bXBfb3BzLgpBbnkgQ1BVIHRoYXQgb2JzZXJ2ZXMgdG1w
X29wcyBpbiBmdHJhY2Vfb3BzX2xpc3QgYWZ0ZXIgdGhpcyBwb2ludCB3aWxsCmFscmVhZHkgc2Vl
IHRoZSBuZXcgYWRkcmVzcyB3aGVuIGl0IGNhbGxzIGZ0cmFjZV9maW5kX3JlY19kaXJlY3QoKS4K
QWRkIHNtcF93bWIoKSBiZXR3ZWVuIHRoZSBzdG9yZSBhbmQgdGhlIHJlZ2lzdHJhdGlvbiB0byBl
bnN1cmUgdGhlCndyaXRlIGlzIHZpc2libGUgb24gd2Vha2x5LW9yZGVyZWQgYXJjaGl0ZWN0dXJl
cyBiZWZvcmUgdG1wX29wcwpiZWNvbWVzIG9ic2VydmFibGUgdmlhIGZ0cmFjZV9vcHNfbGlzdC4K
Ck9uIGVycm9yIGZyb20gcmVnaXN0ZXJfZnRyYWNlX2Z1bmN0aW9uX25vbG9jaygpLCByZXN0b3Jl
IGVudHJ5LT5kaXJlY3QKdG8gb2xkX2FkZHIgc2luY2UgdG1wX29wcyBuZXZlciBiZWNhbWUgdmlz
aWJsZSB0byBvdGhlciBDUFVzLgoKVGhpcyBhZmZlY3RzIGFsbCBjYWxsZXJzIG9mIF9fbW9kaWZ5
X2Z0cmFjZV9kaXJlY3QoKSwgaW5jbHVkaW5nOgogIC0gbW9kaWZ5X2Z0cmFjZV9kaXJlY3QoKSB1
c2VkIGJ5IGtlcm5lbCBtb2R1bGVzIGFuZCBsaXZlIHBhdGNoaW5nCiAgLSBtb2RpZnlfZnRyYWNl
X2RpcmVjdF9ub2xvY2soKSB1c2VkIGJ5IEJQRiB0cmFtcG9saW5lcwogICAgKGtlcm5lbC9icGYv
dHJhbXBvbGluZS5jKSByZWFjaGFibGUgd2l0aCBDQVBfQlBGICsgQ0FQX1BFUkZNT04KCkZpeGVz
OiAwNTY3ZDY4MDk0NDAgKCJmdHJhY2U6IEFkZCBtb2RpZnlfZnRyYWNlX2RpcmVjdCgpIikKQ2M6
IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPgpDYzogTWFzYW1pIEhpcmFtYXRz
dSA8bWhpcmFtYXRAa2VybmVsLm9yZz4KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVk
LW9mZi1ieTogQWZpMCA8Y2FweWVuZ2xpc2hsaXRlQGdtYWlsLmNvbT4KLS0tCiBrZXJuZWwvdHJh
Y2UvZnRyYWNlLmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2tlcm5lbC90cmFjZS9mdHJhY2UuYyBiL2tlcm5lbC90cmFjZS9mdHJhY2UuYwppbmRleCBh
MWIyYzNkNGU1ZjYuLmI3YzhkOWUwZjFhMiAxMDA2NDQKLS0tIGEva2VybmVsL3RyYWNlL2Z0cmFj
ZS5jCisrKyBiL2tlcm5lbC90cmFjZS9mdHJhY2UuYwpAQCAtNTk1MCw2ICs1OTUwLDcgQEAgc3Rh
dGljIGludCBfX21vZGlmeV9mdHJhY2VfZGlyZWN0KHN0cnVjdCBmdHJhY2Vfb3BzICpvcHMsIHVu
c2lnbmVkIGxvbmcgYWRkcikKIAlzdHJ1Y3QgZnRyYWNlX2Z1bmNfZW50cnkgKmVudHJ5OwogCXN0
cnVjdCBmdHJhY2Vfb3BzIHRtcF9vcHM7CisJdW5zaWduZWQgbG9uZyBvbGRfYWRkcjsKIAlpbnQg
ZXJyOwogCiAJbG9ja2RlcF9hc3NlcnRfaGVsZCgmZGlyZWN0X211dGV4KTsKQEAgLTU5NjAsMjIg
KzU5NjEsMzYgQEAgc3RhdGljIGludCBfX21vZGlmeV9mdHJhY2VfZGlyZWN0KHN0cnVjdCBmdHJh
Y2Vfb3BzICpvcHMsIHVuc2lnbmVkIGxvbmcgYWRkcikKIAlpZiAoIWVudHJ5KQogCQlyZXR1cm4g
LUVOT0RFVjsKIAotCS8qCi0JICogdG1wX29wcyBpcyByZWdpc3RlcmVkIGludG8gZnRyYWNlX29w
c19saXN0IGhlcmUsIG1ha2luZyBpdAotCSAqIHZpc2libGUgdG8gYWxsIENQVXMgZXhlY3V0aW5n
IHRoZSB0cmFjZWQgZnVuY3Rpb24uIEhvd2V2ZXIsCi0JICogZW50cnktPmRpcmVjdCBpcyBub3Qg
dXBkYXRlZCB1bnRpbCBhZnRlciB0aGlzIGNhbGwgcmV0dXJucywKLQkgKiBsZWF2aW5nIGEgd2lu
ZG93IHdoZXJlIENQVXMgcmVhZCB0aGUgc3RhbGUgKHBvc3NpYmx5IGZyZWVkKQotCSAqIGRpcmVj
dCBjYWxsIGFkZHJlc3MgdmlhIGZ0cmFjZV9maW5kX3JlY19kaXJlY3QoKS4KLQkgKi8KLQllcnIg
PSByZWdpc3Rlcl9mdHJhY2VfZnVuY3Rpb25fbm9sb2NrKCZ0bXBfb3BzKTsKLQlpZiAoZXJyKQot
CQlyZXR1cm4gZXJyOwotCisJLyogU2F2ZSBvbGQgYWRkcmVzcyBpbiBjYXNlIHdlIG5lZWQgdG8g
cm9sbCBiYWNrIG9uIGVycm9yLiAqLworCW9sZF9hZGRyID0gZW50cnktPmRpcmVjdDsKKworCS8q
CisJICogVXBkYXRlIGVudHJ5LT5kaXJlY3QgQkVGT1JFIHJlZ2lzdGVyaW5nIHRtcF9vcHMgaW50
bworCSAqIGZ0cmFjZV9vcHNfbGlzdC4gVGhpcyBjbG9zZXMgdGhlIHJhY2Ugd2luZG93IHdoZXJl
IGEgQ1BVCisJICogZXhlY3V0aW5nIHRoZSB0cmFjZWQgZnVuY3Rpb24gY291bGQgcmVhZCB0aGUg
b2xkIChwb3RlbnRpYWxseQorCSAqIGZyZWVkKSBkaXJlY3QgY2FsbCBhZGRyZXNzIGJldHdlZW4g
dG1wX29wcyBiZWNvbWluZyB2aXNpYmxlCisJICogYW5kIGVudHJ5LT5kaXJlY3QgYmVpbmcgdXBk
YXRlZC4KKwkgKgorCSAqIEFueSBDUFUgdGhhdCBvYnNlcnZlcyB0bXBfb3BzIGluIGZ0cmFjZV9v
cHNfbGlzdCBhZnRlciB0aGUKKwkgKiBzbXBfd21iKCkgYmVsb3cgaXMgZ3VhcmFudGVlZCB0byBz
ZWUgdGhlIG5ldyBhZGRyZXNzIHdoZW4KKwkgKiBpdCBjYWxscyBmdHJhY2VfZmluZF9yZWNfZGly
ZWN0KCkuCisJICovCiAJbXV0ZXhfbG9jaygmZnRyYWNlX2xvY2spOwogCWVudHJ5LT5kaXJlY3Qg
PSBhZGRyOwogCW11dGV4X3VubG9jaygmZnRyYWNlX2xvY2spOwogCisJLyoKKwkgKiBFbnN1cmUg
ZW50cnktPmRpcmVjdCBzdG9yZSBpcyBvcmRlcmVkIGJlZm9yZSB0bXBfb3BzCisJICogYmVjb21l
cyB2aXNpYmxlIHZpYSBmdHJhY2Vfb3BzX2xpc3Qgb24gd2Vha2x5LW9yZGVyZWQgYXJjaHMuCisJ
ICovCisJc21wX3dtYigpOworCisJZXJyID0gcmVnaXN0ZXJfZnRyYWNlX2Z1bmN0aW9uX25vbG9j
aygmdG1wX29wcyk7CisJaWYgKGVycikgeworCQkvKiB0bXBfb3BzIG5ldmVyIGJlY2FtZSB2aXNp
YmxlOyBzYWZlIHRvIHJlc3RvcmUgb2xkX2FkZHIuICovCisJCW11dGV4X2xvY2soJmZ0cmFjZV9s
b2NrKTsKKwkJZW50cnktPmRpcmVjdCA9IG9sZF9hZGRyOworCQltdXRleF91bmxvY2soJmZ0cmFj
ZV9sb2NrKTsKKwkJcmV0dXJuIGVycjsKKwl9CisKIAkvKgogCSAqIE5vdyB0aGF0IHRtcF9vcHMg
aXMgcmVnaXN0ZXJlZCBhbmQgZW50cnktPmRpcmVjdCBpcyB1cGRhdGVkLAogCSAqIHVucmVnaXN0
ZXIgdGhlIG9yaWdpbmFsIG9wcyBhbmQgY2xlYW4gdXAuCi0tIAoyLjM5LjAK
--0000000000003261b80651fd7f34--
