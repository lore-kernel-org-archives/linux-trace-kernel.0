Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8819EEDF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984414; cv=none; b=K4CCnyjH0nRco1BNrVAbxnrEsGQdC8bFCu5tMe3kBuRgwgluySSmZckgaxi0igOBQxilZfk7iQ/ND+WqixNulcGc6OQmw0kHfEJEH33GnoUlxog3LPYmbqLuHfnDfoiubKKD/33EHaNjljF6rUUQcnmSiFk31fcvrQd1ZiPAXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984414; c=relaxed/simple;
	bh=9Rp+ZaWePBqTv+7CDLYdQhLyxwC0Y6Goq+cudkph1u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYk069Rz67DiXCElnEKMqJzeLOPcyzq2geffUGB4UX13GzYsR/et1TE+haU/qox+ne2ok7yFVBiqzkpaRvCt3Jc+4RMMHa+JCKCiQVG6KYsWU1yVhQIuxnpcpqW9HsvMOdkz4J7VZPQ1ccmv7Bmq0DJgO+b01ftFOmVZCqsbYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VX7WEQ0R; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VX7WEQ0R"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c247dd0899so13120a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725984411; x=1726589211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Rp+ZaWePBqTv+7CDLYdQhLyxwC0Y6Goq+cudkph1u8=;
        b=VX7WEQ0RI41VuuPT5x70ZhL7BMzCNvZkBQ9CpvFjGoN2I1ydOfZyX8Y3ZiWuA371N2
         9xOUVll4yNIhDshgq7rSCi08wQ/4ZviKJ1ge5iRPi/rV3lPuc0S/NKXxI4vUfhczZ0eb
         lo8gCBT1Ar3Rwrv4nrvNrRk+XO2sfVzp+51QZbMhH4Jln/PLnLfAI9YcobvJvNvzQ4t9
         8BecuTyygYglPZW504+I5ZSYGkVFIaYseATK4CKm3aXE3SdeHXfmdtjIqLzzSvmTsTjs
         V8Oa8UNpEWKymwGe0YoWiGbb8e/Xz6wjzkQY+g04gNpEIJKfW6L9GiJeIrZeshhcBldJ
         hEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984411; x=1726589211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Rp+ZaWePBqTv+7CDLYdQhLyxwC0Y6Goq+cudkph1u8=;
        b=YzTBNHWHAKPIE1Fjh5UTUgxCv79TAIp4eW4ndqmpQ6sqE6UO+0SeMKb/mdcFyzWoh/
         GARRzIge31Bib2/XQ5aT2x4xFoDczVlO1rBNQTZhc0sj3T1fXqic+419dIqAxTeSEao3
         0oOz8kxZku7V+QQCVYQLMj49nwS2wttpxoM+GJ6lKZXmlF+4hO8gqQ2JBZ2lriYqr2Bd
         xS4TQW39yGmD/wzcz55JdtcrdJfSDlLcjHavWeur+9ns8+0xZKuMn5W9gaSEYgV5YAKt
         R4mnZzKiVqX6xJoDvbKZSkNyOMV1hfl564/YtzxBjVYbfmAuDCz4gDWdNKCDf1LqLt3p
         yuqA==
X-Gm-Message-State: AOJu0Yyo96vhzKLLmXZMcjZ1kRau/WlpYbp6mhrlIqOeMp2zz3bEEtD2
	BdCYXkVL1heu7kVa2ImrLXJVA4Xe3KiR/Hz257cGi1Xn6fiUD4Uumwd4bse3WX2dO6L00iAKEPM
	HKTJ+ktmPUZF43Zu0ha5P2FhZnxozmlgiUPfo
X-Google-Smtp-Source: AGHT+IHx0FXXNOSwDc/a2GkEEO0nN6J5e6WRL/WX5poMnRTVWbyacane/wtmnLr+FEV9BbUT65Gm5/vLnAoiz2/SvOA=
X-Received: by 2002:a05:6402:1ec4:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5c4029ef54amr299933a12.4.1725984410772; Tue, 10 Sep 2024
 09:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org>
In-Reply-To: <20240906051205.530219-1-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Sep 2024 18:06:12 +0200
Message-ID: <CAG48ez1+Y+ifc3HfG=E5j+g=RwtzH2TiE4mAC2TZxS52idkRZg@mail.gmail.com>
Subject: Re: [PATCH 0/2] uprobes,mm: speculative lockless VMA-to-uprobe lookup
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
> Implement speculative (lockless) resolution of VMA to inode to uprobe,
> bypassing the need to take mmap_lock for reads, if possible. Patch #1 by =
Suren
> adds mm_struct helpers that help detect whether mm_struct were changed, w=
hich
> is used by uprobe logic to validate that speculative results can be trust=
ed
> after all the lookup logic results in a valid uprobe instance.

Random thought: It would be nice if you could skip the MM stuff
entirely and instead go through the GUP-fast path, but I guess going
from a uprobe-created anon page to the corresponding uprobe is hard...
but maybe if you used the anon_vma pointer as a lookup key to find the
uprobe, it could work? Though then you'd need hooks in the anon_vma
code... maybe not such a great idea.
