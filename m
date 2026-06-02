Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB025357D07
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417327; cv=none; b=AVQpslxLCw9sBgrNV4vh7Zf7N/cfh2/IjR3aCUVBu10IIATLCWSqOpKlSqXxNLBE5CF0tvQ+5F6Ll+JRIGD0VvaR3M3EFH1JggZ9MPEkTN5FynKcDVNMFL6NxPRVYOmcQLSD9/kGoHEseK+OZswREKl5qNvAVe0r2yD1/6FWb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417327; c=relaxed/simple;
	bh=XTU/NCL8gqA2JXcsEn0PwDOsIZDKXDOnqfuwiUGWgJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3usOrRysdEye2Wss8+lumldqrPwJf0v059sg/4/J8FSD7GLfxi8i95fAVM/tgJ5MzbLQj8xLedCapwDUmlVBfVatQAyjUXdf07q5KH5YaMIX9mfE1DiOm06Z2XJLY2LA3pQ357UIcPb3XCCQpaOV7OaAhR1aAVTGo6DsbtVqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsRNTG1N; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsRNTG1N"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51761d27612so17502861cf.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 09:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780417326; x=1781022126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca9i8/RrkmCPUjRqV/or9cvyFWAF+0lWZ265m6G8+Xw=;
        b=UsRNTG1NQPvNdxPmJ+vV1b5S4OYK6UlFOv9POuGHJDPYARPad2tuFeHrvqjy2qfioV
         VXqic7K6/nHLScpbF/ne/OgV9+3RKqfzGDhcv3K1cTFYtV4cGVhLyEZh7R4EPqQh8zyh
         04ZE0pzQuwIc9Qhp1QLvGe0GL+aBOZD8JX7j9q7eflSxpddCU+s4S9PKvMG3jIePvQNJ
         SuSGOK58hpvPvR7bKsJ0pcH8xTuUhzz9FbeqJnc43EysIGKPd4Xmh0SPijwLd/TW0VIj
         bnJyi43DYZVwYLPnZKeBZ4kzoaqJPmvjGgXmagHOcxaoWOh32lyOLl4CYqWEut08PxsB
         OtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780417326; x=1781022126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca9i8/RrkmCPUjRqV/or9cvyFWAF+0lWZ265m6G8+Xw=;
        b=LJBEacRqF1DGLYXICiwkw8ce/Z7maX2A8GDK3GDRTm5nmYLPkEQxQEK7ywgOE6cc3A
         5jb+4tD9cHKRvzOb9fSVw64qUGFvE2Ebpihk/BtR8DnhdgQ4togFQlBQ1a5lKfJpqOXu
         RT+2/NIwaplM3DpfBHEKTn8fBarekdDPLpcdrPd4m5BJX4bFtapaDKJ0HhKtRQ5uRVM9
         uHuZRhlfi8HfD4jblR7lQXQbpkFlSbRHVYQ/MKPMpLN2PUB1Cgc0Gm8A32A23pM/6mMB
         8DH8tAjlIOrHeuCyq4d53SWeVjTtEq3ygQqDwhIGCy3Q+oase9w0LuS2wHQvHsFXDNxC
         FRzw==
X-Gm-Message-State: AOJu0Yy/X9M8GS5anYxUOeqrsMEwe5ievKg7nFKUCckfS3yfHUF4C/dO
	IUqvM4VIdC5IoGEw3fjxaZA/zNXQYU5rIX1dcaFIAt/ULYtu/YN1Wl45
X-Gm-Gg: Acq92OHJphd621BUVzH4ObxHRE9AKvCvgchoFXm26W+ZMcBHSmdivAO0dfOIfp9FihF
	9klYovhfJd8/gmTTl0C2svzBESdiRrOZnX4MTdM+ScJeJXDzL91J/U9wD6lJFJovvIZaaG4RZN0
	hTt3tj/Lvphwe0896IHWLmk71BB/NGz7boi72R+LOClYTgprYxAXkLo5Zb8t/pBR1xU+4Er+Eo5
	6GhlKlVR9z39owTOXpih0LIf/S/asiddl+jWHitE1PPEkxUCm4bxWfKJmgFmuy4uDl5xLTEs+cf
	z++keq+J1fy1Pl+LW6Kq1N5IWEvP5oc0OXzN31ucvuX+z9Kn7kbS30dL5OaQX8PrOwShDmaKSS8
	n2MiPYr3/B+j+cflzIYONJW3JQyL2hprPo9NTlMtuEx39wF+PzLXuSpnAnsKL448IX24Jc6C7Ls
	m8OVhOv28p1K7101ZDybShEOytFOb84KrUthRISxCtFK7siwwCYR5bxPC3yScf5d2N0j3xp0Q66
	EfaBK2fAF84veA0ODa0bkmxraLy+g==
X-Received: by 2002:ac8:5909:0:b0:516:e047:2f30 with SMTP id d75a77b69052e-5173a81eca9mr232407601cf.38.1780417325396;
        Tue, 02 Jun 2026 09:22:05 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dd2e53sm2195131cf.24.2026.06.02.09.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:22:04 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtla: Fix parsing of multi-character short options
Date: Tue,  2 Jun 2026 12:21:49 -0400
Message-ID: <20260602162150.75782-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602125506.3325345-1-tglozar@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 2 Jun 2026 14:55:06 +0200, Tomas Glozar wrote:
> rtla: Fix parsing of multi-character short options

Thanks for the fix! I've tested this patch with a comprehensive test suite
covering all rtla commands (timerlat hist/top, osnoise hist/top, hwnoise)
with the four option formats:
  -p 100        (short with space)
  -p100         (short attached - previously broken)
  --period=100  (long with equals)
  --period 100  (long with space)

All 20 tests pass. The fix correctly resolves the issue where -p100 was
being parsed as multiple separate options.

Tested-by: John Kacur <jkacur@redhat.com>
