Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9362620E5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198107; cv=pass; b=lsMJEFZxhtwYX00Pd/PeokAZ7GV6VEUIZnMSV36Hpg4e//q224bis5kqx/kjs9FwJImwhlIKghM6jzjA6DQxyi4i7+7QXkRYZC9bX+lNC4jay+dftL+PZMs2/7Yz76bG25XSg7xNcPUluCwj6nOO2M4xeEWkfeyu9x3DvLN6P5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198107; c=relaxed/simple;
	bh=USuETOR02EbnP9jNk2rssD+vogCYatSUJBzHNjqx5UA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nv6X4/I1I+fyCyZizYv5/8eI2ihkT35JmSAm7Gs/cRZmFs4kBO3UXwPfn3c+REMBNkGj80t65WjTrMA2/Y1N+qmoEozcP7yN9SY7/+ewfKCgg7vZdAQW/MHNkGxfBrYJiI6oOZ1Kq3QzBPmAXMeQ7K43dq4dJO7+zMQuX2IAevc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqwin20d; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqwin20d"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d75d698ee6so785385a34.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Mar 2026 20:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773198104; cv=none;
        d=google.com; s=arc-20240605;
        b=Yk/1ZcAp4BHDoIgkyLAwpap/x4j45JITgAEetPvlAE93AarUaU4+eSHxdpRvuqG6hD
         /4gmvZ0WBwLObwuhqYsQtzLjPwQGsEmGQTNrlpCKzefHzlsBDnZNkOSekKvFIMzmaT3N
         fSICBNZnWCfXaup4A8vRcN27BGFY2ACtrBbsQICjz6+ADYojlAVRR8OzOd0d56nvwyTs
         4K+JbskBedFRvQzXKzOLsT+hcW46a2bSFUv60sLWEyeXFgade/NzfpCJ9G4zoluGiTHj
         Jdg8qPEnrtl69EBEFtYnfBS7H2MseOkFZfEmfuHpSFok3B5kMGWLDmCoei0llrzsA7hR
         l9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lwcYZshukT9x5+YvWHrQP2/uutb5FLKAKZH6xp0g/sg=;
        fh=rAd+XQFLWi1NQY2jwaxwgrjD1Vggs0P3Cb1M+WSpyS0=;
        b=VP9hGm1aqTm6vwm7MQ+OmIRP2R2uwXyhfc1juJJ8G3D+O0XlGKmSgvb4FzkIgSWjMs
         R66Fx7k26TNTrdxmXqyG+s2KKx582nvfVXreUMn5P6Xzf3UCMnc8zdN3jp3f0LbFrFzS
         q77/nWp/o89N+/iJZI1NF/z4IFsmCebfIeXV1srh6d0eCvFQ0pkfeUtabQhYcsdplN2T
         NJA/ewdivwyqRLxQGt5duDC6N3hIYS7KSWYRuh9RbWP6NTmSDeyNvvc7pW6pI/MNaGnJ
         W6gUjABBknTNcv49/mD1KaoRK4IGr5HQJ0sqYOLRiMXsZ8wGvYwN06v1UUlMTOzLKO3n
         m1dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773198104; x=1773802904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lwcYZshukT9x5+YvWHrQP2/uutb5FLKAKZH6xp0g/sg=;
        b=dqwin20dTmizWOEPNxa6+ctOlUBTRtNXbK4U0sGDGJFbFiBM2rAT9NdyWfWaFSHjWI
         7n3a+vKq62BuA/dMIiYFcsWLCtwcNsArGv5cFNkaO2z25V7NcCFHGXsrRxvG9ApQIT1q
         5ohoKGtNLIZHsrJM7VMIwLJbF3ZS4aWM8v/1dxOhPoSoIBPBaQiWq1moZ0zQjGCosJrn
         yNiY8hiuP3GO03TUHmgiAjm5ABdst2BCsvP5IG20xHgkO9f1fJPO+d/gHK85kAyY7Qsd
         a3ov4TU0Xd9D1zS2hzPBo0fSxwkiuoy5Vz3iB0hFmIO86Lekt5DcwHZ/U/xMv1s9HSqk
         rLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773198104; x=1773802904;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwcYZshukT9x5+YvWHrQP2/uutb5FLKAKZH6xp0g/sg=;
        b=Jf4vxDmPH++IoogAWrukbuch9u+4wdv1WlleLHghRXkjIBM4JzTFq02L/j38VsB1G3
         X62BuT8rqt/zzggCTMIz4qgyPOvtwe5dVcYFAwUW6DO9jlAOcC2hsI1l3b8bR4UO++Q7
         NFid9nGC6IZkx/3y4nwoiQvF5dnw3EfjTtpx4Vrv+1kyxuUhxnf9dNxje655ORgaTG17
         rntOpxCKZwUhAspzNdsv/yV9kq/Jy9pAuNtohlsFKgHlcDvr5Sw7qQYFjhisreksFkVl
         WcVDSwG5c8QMR8CnSVi8u4Gpn1yq/gj5eBpag1L53LkXF+OhMmETbhcEUpoFXU51q7Zp
         r/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCU0CtOTSdJqo/c0TnFzfl/cjcxzA32+t06NnLLlIYx5D7A7ZT7DEakWPx0Wef8nUYTaxXtVkmQry6VC2Lbb7RscafY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfUSny2yIrrItyohAzgV2uXHYiVmN3Qocejth32KxE60fx29vi
	7EJUjcrGq6P/wncq+RPDxTNdu30BRcmlE+o2aBgE1GR6MacZ1oAi+pBpqQ4yZ4I60O8JUkDzsGw
	U/GrqxvY8wULZEXAlNp131e3pK6yPxuA=
X-Gm-Gg: ATEYQzwkM5ufwbVl979MKqJ4s+LE/6fU9uxcyL4MJkDyAARrb7B3+YKOLOPCY0E0qUX
	bUReza90syQDarU+N0HqPiBLr4Sdtz6eiuAr9AQF0xx75jOoHesF8fmJiDPwLvMYlt/STwwnwv/
	UmBrYJiBnkOoPQjwfAB2AlR99wknY6iW79u1Dc+1iPIWc1BqtUFKhlh6sYAKlmWIApfWQoNQafQ
	VTX+GPm3L6kC1v9uNEpGvHmojlJwF01owR5IVlpGiUG+rd1gXxjQz00s2RWRYgE4bLiqg2dMmND
	BZXEPaY=
X-Received: by 2002:a05:6830:81c7:b0:7d7:51a4:d071 with SMTP id
 46e09a7af769-7d76a741d8dmr792249a34.15.1773198103815; Tue, 10 Mar 2026
 20:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Oli <oochiolio@gmail.com>
Date: Tue, 10 Mar 2026 22:01:41 -0500
X-Gm-Features: AaiRm50y1v-api-VJGGCuow_byrgIvm0KBWdyp52p0mvuaQCzwMEaVOX9UDzfF0
Message-ID: <CAOW84UxjnSDKSjsaaS9=DBquCk3SDfb74=OmkHTLUyq5qriYsA@mail.gmail.com>
Subject: [PATCH] Remove unused headers in x86/tools, scripts, pps, input
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Rodolfo Giometti <giometti@enneenne.com>, Henrik Rydberg <rydberg@bitmath.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-input@vger.kernel.org, x86@kernel.org
Content-Type: multipart/mixed; boundary="000000000000183e26064cb6dbe3"

--000000000000183e26064cb6dbe3
Content-Type: multipart/alternative; boundary="000000000000183e26064cb6dbe1"

--000000000000183e26064cb6dbe1
Content-Type: text/plain; charset="UTF-8"

From c78a0572f5ec2b927f9b723af687e6ef913561a4 Mon Sep 17 00:00:00 2001
From: Eddie Hudgins <Oochiolio@gmail.com>
Date: Tue, 10 Mar 2026 21:53:07 -0500
Subject: [PATCH] Signed-off-by: Eddie Hudgins <Oochiolio@gmail.com>
 arch/x86/tools: Removed headers in relocs_32.c scripts/basic: Removed
headers
 in fixdep.c drivers/pps: Removed headers in pps.c drivers/input: Removed
 headers in input-mt.c

These changes compile for x86, x86_64, and powerpc (Those were the only
ones fairly tested) under defconfig. This aims to clean up code and
simplify the files for developers. This will also contribute to start of
decluttering the environment.
---
 arch/x86/tools/relocs_32.c | 1 -
 drivers/input/input-mt.c   | 1 -
 drivers/pps/pps.c          | 3 ---
 scripts/basic/fixdep.c     | 1 -
 4 files changed, 6 deletions(-)

diff --git a/arch/x86/tools/relocs_32.c b/arch/x86/tools/relocs_32.c
index 9442ff78be83..9e4668e74993 100644
--- a/arch/x86/tools/relocs_32.c
+++ b/arch/x86/tools/relocs_32.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "relocs.h"
-
 #define ELF_BITS 32

 #define ELF_MACHINE            EM_386
diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index c06e98fbd77c..b553b7f2313a 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -7,7 +7,6 @@

 #include <linux/input/mt.h>
 #include <linux/export.h>
-#include <linux/slab.h>
 #include "input-core-private.h"

 #define TRKID_SGN      ((TRKID_MAX + 1) >> 1)
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index c6b8b6478276..a9a8802c2399 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -7,14 +7,11 @@

 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/idr.h>
 #include <linux/mutex.h>
-#include <linux/cdev.h>
 #include <linux/poll.h>
 #include <linux/pps_kernel.h>
 #include <linux/slab.h>
diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index cdd5da7e009b..feb9e7d8984d 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -89,7 +89,6 @@
  *  but I don't think the added complexity is worth it)
  */

-#include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
 #include <fcntl.h>
--
2.43.0

--000000000000183e26064cb6dbe1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">From c78a0572f5ec2b927f9b723af687e6ef913561a4 Mon Sep 17 0=
0:00:00 2001<br>From: Eddie Hudgins &lt;<a href=3D"mailto:Oochiolio@gmail.c=
om">Oochiolio@gmail.com</a>&gt;<br>Date: Tue, 10 Mar 2026 21:53:07 -0500<br=
>Subject: [PATCH] Signed-off-by: Eddie Hudgins &lt;<a href=3D"mailto:Oochio=
lio@gmail.com">Oochiolio@gmail.com</a>&gt;<br>=C2=A0arch/x86/tools: Removed=
 headers in relocs_32.c scripts/basic: Removed headers<br>=C2=A0in fixdep.c=
 drivers/pps: Removed headers in pps.c drivers/input: Removed<br>=C2=A0head=
ers in input-mt.c<br><br>These changes compile for x86, x86_64, and powerpc=
 (Those were the only ones fairly tested) under defconfig. This aims to cle=
an up code and simplify the files for developers. This will also contribute=
 to start of decluttering the environment.<br>---<br>=C2=A0arch/x86/tools/r=
elocs_32.c | 1 -<br>=C2=A0drivers/input/input-mt.c =C2=A0 | 1 -<br>=C2=A0dr=
ivers/pps/pps.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 ---<br>=C2=A0scripts/=
basic/fixdep.c =C2=A0 =C2=A0 | 1 -<br>=C2=A04 files changed, 6 deletions(-)=
<br><br>diff --git a/arch/x86/tools/relocs_32.c b/arch/x86/tools/relocs_32.=
c<br>index 9442ff78be83..9e4668e74993 100644<br>--- a/arch/x86/tools/relocs=
_32.c<br>+++ b/arch/x86/tools/relocs_32.c<br>@@ -1,6 +1,5 @@<br>=C2=A0// SP=
DX-License-Identifier: GPL-2.0<br>=C2=A0#include &quot;relocs.h&quot;<br>-<=
br>=C2=A0#define ELF_BITS 32<br><br>=C2=A0#define ELF_MACHINE =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0EM_386<br>diff --git a/drivers/input/input-mt.c=
 b/drivers/input/input-mt.c<br>index c06e98fbd77c..b553b7f2313a 100644<br>-=
-- a/drivers/input/input-mt.c<br>+++ b/drivers/input/input-mt.c<br>@@ -7,7 =
+7,6 @@<br><br>=C2=A0#include &lt;linux/input/mt.h&gt;<br>=C2=A0#include &l=
t;linux/export.h&gt;<br>-#include &lt;linux/slab.h&gt;<br>=C2=A0#include &q=
uot;input-core-private.h&quot;<br><br>=C2=A0#define TRKID_SGN =C2=A0 =C2=A0=
 =C2=A0((TRKID_MAX + 1) &gt;&gt; 1)<br>diff --git a/drivers/pps/pps.c b/dri=
vers/pps/pps.c<br>index c6b8b6478276..a9a8802c2399 100644<br>--- a/drivers/=
pps/pps.c<br>+++ b/drivers/pps/pps.c<br>@@ -7,14 +7,11 @@<br><br>=C2=A0#def=
ine pr_fmt(fmt) KBUILD_MODNAME &quot;: &quot; fmt<br><br>-#include &lt;linu=
x/kernel.h&gt;<br>=C2=A0#include &lt;linux/module.h&gt;<br>=C2=A0#include &=
lt;linux/init.h&gt;<br>-#include &lt;linux/sched.h&gt;<br>=C2=A0#include &l=
t;linux/uaccess.h&gt;<br>=C2=A0#include &lt;linux/idr.h&gt;<br>=C2=A0#inclu=
de &lt;linux/mutex.h&gt;<br>-#include &lt;linux/cdev.h&gt;<br>=C2=A0#includ=
e &lt;linux/poll.h&gt;<br>=C2=A0#include &lt;linux/pps_kernel.h&gt;<br>=C2=
=A0#include &lt;linux/slab.h&gt;<br>diff --git a/scripts/basic/fixdep.c b/s=
cripts/basic/fixdep.c<br>index cdd5da7e009b..feb9e7d8984d 100644<br>--- a/s=
cripts/basic/fixdep.c<br>+++ b/scripts/basic/fixdep.c<br>@@ -89,7 +89,6 @@<=
br>=C2=A0 * =C2=A0but I don&#39;t think the added complexity is worth it)<b=
r>=C2=A0 */<br><br>-#include &lt;sys/types.h&gt;<br>=C2=A0#include &lt;sys/=
stat.h&gt;<br>=C2=A0#include &lt;unistd.h&gt;<br>=C2=A0#include &lt;fcntl.h=
&gt;<br>--<br>2.43.0</div>

--000000000000183e26064cb6dbe1--
--000000000000183e26064cb6dbe3
Content-Type: application/octet-stream; 
	name="0001-Signed-off-by-Eddie-Hudgins-Oochiolio-gmail.com.patch"
Content-Disposition: attachment; 
	filename="0001-Signed-off-by-Eddie-Hudgins-Oochiolio-gmail.com.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mmlgd5rv0>
X-Attachment-Id: f_mmlgd5rv0

RnJvbSBjNzhhMDU3MmY1ZWMyYjkyN2Y5YjcyM2FmNjg3ZTZlZjkxMzU2MWE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFZGRpZSBIdWRnaW5zIDxPb2NoaW9saW9AZ21haWwuY29tPgpE
YXRlOiBUdWUsIDEwIE1hciAyMDI2IDIxOjUzOjA3IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gU2ln
bmVkLW9mZi1ieTogRWRkaWUgSHVkZ2lucyA8T29jaGlvbGlvQGdtYWlsLmNvbT4KIGFyY2gveDg2
L3Rvb2xzOiBSZW1vdmVkIGhlYWRlcnMgaW4gcmVsb2NzXzMyLmMgc2NyaXB0cy9iYXNpYzogUmVt
b3ZlZCBoZWFkZXJzCiBpbiBmaXhkZXAuYyBkcml2ZXJzL3BwczogUmVtb3ZlZCBoZWFkZXJzIGlu
IHBwcy5jIGRyaXZlcnMvaW5wdXQ6IFJlbW92ZWQKIGhlYWRlcnMgaW4gaW5wdXQtbXQuYwoKVGhl
c2UgY2hhbmdlcyBjb21waWxlIGZvciB4ODYsIHg4Nl82NCwgYW5kIHBvd2VycGMgKFRob3NlIHdl
cmUgdGhlIG9ubHkgb25lcyBmYWlybHkgdGVzdGVkKSB1bmRlciBkZWZjb25maWcuIFRoaXMgYWlt
cyB0byBjbGVhbiB1cCBjb2RlIGFuZCBzaW1wbGlmeSB0aGUgZmlsZXMgZm9yIGRldmVsb3BlcnMu
IFRoaXMgd2lsbCBhbHNvIGNvbnRyaWJ1dGUgdG8gc3RhcnQgb2YgZGVjbHV0dGVyaW5nIHRoZSBl
bnZpcm9ubWVudC4KLS0tCiBhcmNoL3g4Ni90b29scy9yZWxvY3NfMzIuYyB8IDEgLQogZHJpdmVy
cy9pbnB1dC9pbnB1dC1tdC5jICAgfCAxIC0KIGRyaXZlcnMvcHBzL3Bwcy5jICAgICAgICAgIHwg
MyAtLS0KIHNjcmlwdHMvYmFzaWMvZml4ZGVwLmMgICAgIHwgMSAtCiA0IGZpbGVzIGNoYW5nZWQs
IDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdG9vbHMvcmVsb2NzXzMyLmMg
Yi9hcmNoL3g4Ni90b29scy9yZWxvY3NfMzIuYwppbmRleCA5NDQyZmY3OGJlODMuLjllNDY2OGU3
NDk5MyAxMDA2NDQKLS0tIGEvYXJjaC94ODYvdG9vbHMvcmVsb2NzXzMyLmMKKysrIGIvYXJjaC94
ODYvdG9vbHMvcmVsb2NzXzMyLmMKQEAgLTEsNiArMSw1IEBACiAvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMAogI2luY2x1ZGUgInJlbG9jcy5oIgotCiAjZGVmaW5lIEVMRl9CSVRT
IDMyCiAKICNkZWZpbmUgRUxGX01BQ0hJTkUJCUVNXzM4NgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
bnB1dC9pbnB1dC1tdC5jIGIvZHJpdmVycy9pbnB1dC9pbnB1dC1tdC5jCmluZGV4IGMwNmU5OGZi
ZDc3Yy4uYjU1M2I3ZjIzMTNhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L2lucHV0LW10LmMK
KysrIGIvZHJpdmVycy9pbnB1dC9pbnB1dC1tdC5jCkBAIC03LDcgKzcsNiBAQAogCiAjaW5jbHVk
ZSA8bGludXgvaW5wdXQvbXQuaD4KICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4KLSNpbmNsdWRl
IDxsaW51eC9zbGFiLmg+CiAjaW5jbHVkZSAiaW5wdXQtY29yZS1wcml2YXRlLmgiCiAKICNkZWZp
bmUgVFJLSURfU0dOCSgoVFJLSURfTUFYICsgMSkgPj4gMSkKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cHBzL3Bwcy5jIGIvZHJpdmVycy9wcHMvcHBzLmMKaW5kZXggYzZiOGI2NDc4Mjc2Li5hOWE4ODAy
YzIzOTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcHBzL3Bwcy5jCisrKyBiL2RyaXZlcnMvcHBzL3Bw
cy5jCkBAIC03LDE0ICs3LDExIEBACiAKICNkZWZpbmUgcHJfZm10KGZtdCkgS0JVSUxEX01PRE5B
TUUgIjogIiBmbXQKIAotI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgogI2luY2x1ZGUgPGxpbnV4
L21vZHVsZS5oPgogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KLSNpbmNsdWRlIDxsaW51eC9zY2hl
ZC5oPgogI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4KICNpbmNsdWRlIDxsaW51eC9pZHIuaD4K
ICNpbmNsdWRlIDxsaW51eC9tdXRleC5oPgotI2luY2x1ZGUgPGxpbnV4L2NkZXYuaD4KICNpbmNs
dWRlIDxsaW51eC9wb2xsLmg+CiAjaW5jbHVkZSA8bGludXgvcHBzX2tlcm5lbC5oPgogI2luY2x1
ZGUgPGxpbnV4L3NsYWIuaD4KZGlmZiAtLWdpdCBhL3NjcmlwdHMvYmFzaWMvZml4ZGVwLmMgYi9z
Y3JpcHRzL2Jhc2ljL2ZpeGRlcC5jCmluZGV4IGNkZDVkYTdlMDA5Yi4uZmViOWU3ZDg5ODRkIDEw
MDY0NAotLS0gYS9zY3JpcHRzL2Jhc2ljL2ZpeGRlcC5jCisrKyBiL3NjcmlwdHMvYmFzaWMvZml4
ZGVwLmMKQEAgLTg5LDcgKzg5LDYgQEAKICAqICBidXQgSSBkb24ndCB0aGluayB0aGUgYWRkZWQg
Y29tcGxleGl0eSBpcyB3b3J0aCBpdCkKICAqLwogCi0jaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiAj
aW5jbHVkZSA8c3lzL3N0YXQuaD4KICNpbmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRlIDxmY250
bC5oPgotLSAKMi40My4wCgo=
--000000000000183e26064cb6dbe3--
