Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D0B320A00
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037491; cv=none; b=cVZL4W4R0vuOKWkypqbEw6xFQ7M7bNcf+eluq03hnJqnrJg6KuANi7vFQwCjDcPlGbsv3Fe8uzq7dL8D9cMxfRWeKe318vgsW1lU1rAhY+73M3t/scJvnoE3mONDBwWcHOlivSm5muceLmE3CsHQfUv3RL6VQiKp6ipGsBzQ2Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037491; c=relaxed/simple;
	bh=xtUfDTogkvswBHYd+l0SxFxD1eU2IzxbiBtqrmpreT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kek3A5dS3XvODd50MCOBD5Dj4eZe2e088DbrRsxuTCoguGVZXw8PpHuAGSzEUuz3jaolNJR4yWkuB8wrIsx1mB5DkCRAUJ9ENB6ujw6PY1VDvXHnWsrRylAPU9ipuZEHuSFq8r2wIxNqSwxTupUdmjggIAGPSYTdIENyugw04gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfxCRyjZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfxCRyjZ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc147d86bebso466328a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 17:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790037489; x=1790642289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vK9yWKbLePV+PhIzuB8+Y294NhkTxfEqJ9/AYRPGsHs=;
        b=KfxCRyjZajsnFb9ivUs+xhCuHmKO/PGGnrxIivzb74I51zUSN3Bsri+kgG5o+3O7Qs
         X6diPDceo5NOq5qK1r5EsEQQXeeIyyPyAyqbmIkKWX93BkqDJFTHvROJaKfL5Ma9/IBs
         qPtjGdjKcP7xbvcPE9YcZfTYlfZMYIpLzYaCeCJiqRUumZ84a1a/f3jGHRW4caQdATWY
         JHztINCz/tSOkX+ZYh7zEdOE9m7kae4QsQSsRNeN+Zgjp0TpH3PmiWuyX6MjcLJ+4de8
         QN4oUBihX98sKCf6oLzwaKRKKXhw0X6cPcRlDWTMOzjUFM67dvXpzg03OpBg4lRUXTj+
         wKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790037489; x=1790642289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vK9yWKbLePV+PhIzuB8+Y294NhkTxfEqJ9/AYRPGsHs=;
        b=sdm6EyVhvS5oX2k/6gfDJ3b9NCvjJUcxtt0GobFMnfHVXsvbkw2qyvdTOy4hdAGpKN
         TBtddp8V9UYPqSy01qFuIcE0uc+Nw7h61BWVASYGM1+uw0QWJBkN5iJ0K0sJPTPPoOXl
         nWSaSH2Adq90wUzZLcmi8QKyjp7rmaAKOg7Psw6y/nrYQqZrDmPeb1WWsj9HPJbPyhaO
         T+Leue5CYCEsHgfYP09zhkPFqxIbwPhSwnFGiic1FZiZJvURaAJ2PhKc8omVFvPZIvff
         P48+q8FtJWrvs0lAZuxAUxSJ7UdWZ8QTYk06mjySzBsI6l+DugWhsdfrborIpNgqkQsh
         5kwg==
X-Forwarded-Encrypted: i=1; AKwUvBxSWFxrjNfF3xFcnnBdujbEf7t2hxqwh0H9w56rSBqyHAo9dz0+jeGcm9oWuYvB4n9ZkhR6ew8pH9dzUnPGuXFCLBk=@vger.kernel.org
X-Gm-Message-State: AFuF++nCSuT5KFyLrBmg4PqDTQ2uR45Z49FbUJlf0rulFVPOQEtk9bIY
	M/bo3rmQ/Wn28N7c2iqG/s0fvG3a5ckjQzWftKLuJ96tgySmrfY3fvnlITnD5+E=
X-Gm-Gg: AYBFou0HUfgOIj2vAMR1acluPLelWJAeAWEFFpRZaSIRiSL6tML9ENRu+J4zzZwLXYI
	eR8rc9G5IexBsPEfqC0a73lEQCLJmuAI650hVL7r7jbeZh5RC2rnTXZngIzGFDTpS/7C1Nu76PX
	86lx9WMao+0IGiXxn/cUzE2Q2/i0VDUF+GuNDFCrpFMsNMVmTxA6e83wLClYcOJahq8aBBX7s1N
	GrOAsPL8AMabq4jhyYPbd1/+yNaUmmdFlTTW8mUM2R5v8imND/MMpjhQqva5qRJRZtocWt4r5/A
	iWpEphnkkR5Ue9W7cEqNV8YFThjYK1Vbqrfjooe0z2yRcQnm5BKLgl6lTHqR51xey0j7jJpFauG
	/mG1n3YKrUE5bwIJcJ2bgu2Co7cjx8FZ7IClNOdaqMHQr9nOdE+vpbZnNbu5HtWD1Erg/2Cl+EM
	h272ZrSpgtRw0MQexLHwiK8yBf4EEo3BXlMDK6FJL8d5USlY02gm7jqvjo/z3LPQN6nhreBJwIn
	FFk4qya+DqMpuqARFZWnuk3
X-Received: by 2002:a05:6a21:e8c:b0:3d3:aed2:6f21 with SMTP id adf61e73a8af0-3dde01c1bfcmr1241002637.21.1790037488713;
        Mon, 21 Sep 2026 17:38:08 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:38b7:a3:b37e:ac86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756a18ddbsm15551a12.7.2026.09.21.17.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 17:38:07 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: vdonnefort@google.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH v1] ring-buffer: Fix the sub-buffer array base in rb_meta_subbuf_idx()
Date: Tue, 22 Sep 2026 09:38:02 +0900
Message-ID: <20260922003802.1270847-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arDlCou_U1nV9Zqq@google.com>
References: <20260918071507.1019251-1-donggeunyoo.kernel@gmail.com> <arDlCou_U1nV9Zqq@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 21, 2026 at 09:04:26AM +0100, Vincent Donnefort wrote:
> Looking at the delta between rb_meta_subbuf_idx() and rb_range_align_subbuf, it
> seems it's just the former didn't include that struct ring_buffer_cpu_meta
> isn't?

Right -- the sizeof(struct ring_buffer_cpu_meta) term was missing.

> That is quite long commit description just to say that :)

Fair enough.  I will keep them shorter.

Thanks for the review.

Donggeun
