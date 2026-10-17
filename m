Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591DA187346
	for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279551; cv=none; b=GcnKAlqz1QlE4CRCuZAotna+kg0aBKEMaSTN5sKIlQqZfTyslQBmSg05xyz4VEbnnZQCR3sHus0/bkdRAoQ1IV1KzBYtLpoBNfgmY5cN5rUZ34dTnYmA9VigYizS+0EeKmkz47QMPHjNTSitMONOyLC/ubOHMUv9hsPEFSoy9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279551; c=relaxed/simple;
	bh=76+A5Jj0Hlrf12TczBu4HUo2tmyicY+Onp4kmxXjTS4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=uSoTLa5JYJyyBJswvQcUilkQ45krSZlY0qhvGDxfdPGmUeqF4dPTlIdfBqXhdvQCWPconEIPz0awZVxxIDMRwlVS3u+A7A0uDp6gEggkXGRr/0HH0HJbOcvzRKGMUiiPPnQMhI/xA41HdEue/HUdpVfsypqCie3wTLtM7I0cjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvnA718d; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvnA718d"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e977109392so3879385ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792279550; x=1792884350; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=76+A5Jj0Hlrf12TczBu4HUo2tmyicY+Onp4kmxXjTS4=;
        b=PvnA718dzQSvfwkiDZjhzgwLANqqLbdoUPGy9N21Kzk6M2oSbtE//CVIdcbO2jsFfC
         nXKu9lqnL4KqfRB4mxYVN5O2RssqWQgy6x4CdSf3+qPlRKPIRaTMciUnph/hmkob3b20
         LGFYZ3mgIBOXmRkKkUhfWxq9+hU2VLpbwMMHGbUzNxCDerur8U8ChNW5eF8v4fjDcuTG
         dolkhC12W/5n3g+ZXW9zajfq28vtCvJJ6359jSfU4EHR0NcJCXwIqJ4Ld9KHjppwMFnN
         OPP+55gJBH6j7ipnjoLqJ1SvuxytuavAV9dvcFy+OGMF1rc2KdGO6t9qDxlZRsuPgr4l
         emGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792279550; x=1792884350;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76+A5Jj0Hlrf12TczBu4HUo2tmyicY+Onp4kmxXjTS4=;
        b=Qs0phE0BkNJBoTm4wZujdONgYZ4OMLpdsIQs2Cf+2nKdkJ1EXCu5RGwZoT9RAoN0QV
         7t8Cnh9HItiqtkbiYOIxkIVqamFpGfjEDphOfyQOiVV3Q1ZWy6GXXH3VMPXNEdeMwW8g
         yokjI4tLrjcVBm8BkGZ8FIrUazFmo/Q1JdYdkQ5mALvnEwHZLKdiTQyc2/UJWPVI50EW
         kpenRqM+Oh8wxQm5VvTeZJ4vOG4B3wyqgsH0eUe2aKVW9hX86CtLSjlmlSya+dbb5uMn
         fnMefxn7wQFmLJKfv6uDxceRrIPpA1IX5xgMsXSUOukR5ULPkmpMNvJ9i61gROIH2iEM
         ikjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxN+FQFIERR7IOBSMefudeE+iz037FnusYnGROE6esG/FgVHWPkasicu7cXj7/Cu/+Ad779/jpT7epj+OfHXJpbt8U=@vger.kernel.org
X-Gm-Message-State: AFq9FYL563Ybpoi7Y13CmfueAW+ZIKj0/UJlQr/stGa9Sz6HwMSSBbKc
	IM56MIz1OB0rHJMPXpzEMGhaPeDEXkh6VBSHDdyrxOTPwsXbbAaPkSEP
X-Gm-Gg: AYBFou2+RSiHW8Z+J0Tda28aSyBw/1kWKhPaBa/CXlDpblGe0tfrsGyukEmLTnoJ6zw
	1Db/aKMcZa5A53TO3rZgHrq18csixBWulBKUQ0p5jpmKKPmTQYwNcU9w+KaJu6g2KBujC9BwngG
	Rip33y8EuwlYaEqfH5YBBlczg9cHr+3+0C6QfJ54k2v+Zl+4PVm5uGA5clIajIHduk/baC27AAn
	uiWPkPsc7OpeA99j0C/QdMV+nfLzPXI+TAQwUY88Bx9gojIUS0pHGMG/TOYrcca7y2hx6LqKvbd
	QaJYZUi4AnP000B80dQGquGEp/569UIffucypOrJmF6a78d/I112yYjtpeIxQ2UOhQQGYFWu9WY
	ilzORC0EyKwqd1UbSpkXoAdqz0Wb5y8cXOvdwEncOxt7iZDgM6x/eG1jn24Y6zYxjVjhvmfE3BR
	L3UbSlynaUbXvP4ZWrkRy3g0PzuOvcAmLBQYPUKmOaxtzx3VM5QoBK5bWFA4KkW6F0MX0JRkIWm
	X5ZHH+g9kpZguwGWzENniJQpJoSPC8/UBwELu+cy0eNqekXaADTP7KxuuUbEKd6u//ZltwGnoyr
	1bY=
X-Received: by 2002:a17:903:24b:b0:2e5:41dc:9ac7 with SMTP id d9443c01a7336-2e9a6d252a3mr32793975ad.24.1792279549582;
        Sat, 17 Oct 2026 16:25:49 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87994bsm24216375ad.60.2026.10.17.16.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 16:25:48 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 23:25:48 +0000
Message-Id: <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
Cc: "Nam Cao" <namcao@linutronix.de>, "Wen Yang" <wen.yang@linux.dev>,
 "Tobias Schaffner" <tobias.schaffner@siemens.com>, "Viktor Malik"
 <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "John Ogness" <john.ogness@linutronix.de>, "Gabriele Monaco"
 <gmonaco@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
In-Reply-To: <87v770uuyr.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com> <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com> <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de> <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com> <87bj8s8ih9.fsf@jogness.linutronix.de> <DM78SVMBI2XW.2XHVC67VON48A@gmail.com> <87v770uuyr.fsf@jogness.linutronix.de>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 07:02 PM John Ogness <john.ogness@linutronix.de> wrote:
> It would be nice if it could be filtered so that only RV violation
> bpf_printk's would trigger. I do not think it is possible for a filter
> to do primitive pattern matching on @bpf_string. Or am I wrong?

not an ftrace expert, but it should be possible. bpf_string is
a dynamic string field and filters take globs on those.

> With the "new" ringbuffer and nbcon implementations, it no longer dos-es
> the kernel, so I have no problem with bpf programs calling
> printk_deferred(). And besides, userspace can already blast the
> ringbuffer and consoles via /dev/kmsg.

well, /dev/kmsg is ratelimited unless printk.devkmsg=on,
but the kfunc wouldn't be.
I still feel that bpf_stream + user space that writes into
/dev/kmsg is a better design.
