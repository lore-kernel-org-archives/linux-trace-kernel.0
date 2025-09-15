Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7150320A17;
	Mon, 15 Sep 2025 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947041; cv=none; b=C8JYyL4Rf+KGLlHwovE8yi9GybQdvYtJA21yHeChBqUWVl9GAMZdVwH4GWtWUwllHW2J8mNNLCiyebh96b/1jdYviIIxRzyEPAG8CuTHxRsloMUnhzu/oicieUOcg6xYEimbOcwM8jBKD8kwGO9dO8RFyx9haoc3x+gOboiQ+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947041; c=relaxed/simple;
	bh=4F79abvdGAdbyFcQAGB43etL6vwoT9Ad2tdcs0ambeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qibI77yREAmt8VnCDzSAVTDGorFRM7KfVCYoTon2IWFPuQiDuDQs2nSymdG7i5xYbe6KQSgd1XZ7NZQDG3FazSXQ5R71wAFNIj56/QvDTbKwR+aro/oEV1K51egURWYI8q1hRchecK6qrRu1bpxWcfIKB8UGOroOE+WdmjZ3x7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaa6zbq5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaa6zbq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8DAC4CEF1;
	Mon, 15 Sep 2025 14:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947040;
	bh=4F79abvdGAdbyFcQAGB43etL6vwoT9Ad2tdcs0ambeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iaa6zbq56CcFRPv/KV0SbxptCtRM/XJQEu0Dd7mhWiYjlLsFmkHRhLMA2mSxZx2Oc
	 uRvnW9OUImU+tWLbfOVS1XeWhv//GzftSqQENAM/iZmAOikc9iv+QRg2UG9FgIiaws
	 +hx5yG6laNn4pTSKo1R9No82xnr1zOvSZWtPyJJ8gg6tbnL7HhCll2GEUEAAVDE1MU
	 K1mgYs5loLdjfHu858y4YrTiZWu4qrit8A8S0zk7DI+09ySD0K4+3x+suFoORSkL3k
	 aEQSKVvcKMUb4O8dIdKDj0BozJoWxBq4wT5pfXJ1O3Iz41uuoLyf8VZa/hJXx2XAvE
	 9ZJUY01ZVjNKA==
From: Christian Brauner <brauner@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] rv/ltl_monitor: adapt handle_task_newtask to u64 clone_flags
Date: Mon, 15 Sep 2025 16:37:15 +0200
Message-ID: <20250915-hemmen-neuartig-0315104a9d78@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250904-trace-task-newtask-fix-callbacks-v1-1-8edb3d557365@siemens-energy.com>
References: <20250904-trace-task-newtask-fix-callbacks-v1-1-8edb3d557365@siemens-energy.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=brauner@kernel.org; h=from:subject:message-id; bh=4F79abvdGAdbyFcQAGB43etL6vwoT9Ad2tdcs0ambeE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScUJmdr/Vgupieu/eiXxtLLHYaFW74+9HJuuLT3EezM ufP61h4vKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiCjaMDNOj9DlkOROiq3Ms I3aVxJYFmCSGqa+3XLi4/cKxVdwXwhj+Kccrqi+QeD3P+YHL2Y0u+f9NG1bn9by1v2LQoyL64Jo dEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 04 Sep 2025 13:36:52 +0200, Simon Schuster wrote:
> Since commit edd3cb05c00a ("copy_process: pass clone_flags as u64 across
> calltree") the task_newtask trace event exposes clone_flags as u64 to
> its callbacks.
> 
> However, ltl_monitor was not adapted, resulting in a faulty callback.
> This also resulted in an lkp build warning due to
> -Wincompatible-pointer-types.
> 
> [...]

Applied to the kernel-6.18.clone3 branch of the vfs/vfs.git tree.
Patches in the kernel-6.18.clone3 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: kernel-6.18.clone3

[1/1] rv/ltl_monitor: adapt handle_task_newtask to u64 clone_flags
      https://git.kernel.org/vfs/vfs/c/02bf8f2f7ccb
